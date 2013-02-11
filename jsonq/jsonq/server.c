#include "io.h"
#include <event2/listener.h>
#include <event2/buffer.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

struct message {
    struct io *io;
    struct evbuffer *evbuf;
};

struct message *message_new(struct io *io)
{
    struct message *message = (struct message *) malloc(sizeof(*message));
    message->io = io;
    message->evbuf = evbuffer_new();
    return message;
}

void message_delete(struct message *message)
{
    evbuffer_free(message->evbuf);
    free(message);
}

static void server_read_callback(struct bufferevent *bev, void *ctx)
{
    struct message *message = (struct message *) ctx;
    debug_print(0, "read cb=%p", bev);
    bufferevent_read_buffer(bev, message->evbuf);
}

static void server_write_callback(struct bufferevent *bev, void *ctx)
{
    struct message *message = (struct message *) ctx;
    debug_print(0, "write cb=%p", bev);
    bufferevent_write_buffer(bev, message->evbuf);
}

static void server_event_callback(struct bufferevent *bev, short events, void *ctx)
{
    struct message *message = (struct message *) ctx;
    if (events & BEV_EVENT_EOF) {
        debug_print(1, "client disconnect");
    } else if (events & BEV_EVENT_TIMEOUT) {
        debug_print(1, "client timeout e=%p, events=%x", bev, events);
    } else {
        /* Other case, maybe error occur */
    }
    message_delete(message);
    bufferevent_free(bev);
}

static void server_accept_callback(struct evconnlistener *lev, evutil_socket_t fd, struct sockaddr *sa, int socklen, void *ctx)
{
    (void)socklen;
    struct io *io = (struct io *) ctx;
    struct event_base *base = evconnlistener_get_base(lev);
    struct bufferevent *bev;

    debug_print(1, "client connect from [%s:%u] over fd [%d]",
            inet_ntoa(((struct sockaddr_in *) sa)->sin_addr),
            (unsigned short) ntohs(((struct sockaddr_in *) sa)->sin_port), fd);

    bev = bufferevent_socket_new(base, fd, BEV_OPT_CLOSE_ON_FREE);
    if (bev == NULL) {
        debug_print(0, "bufferevent_socket_new() failed");
        evutil_closesocket(fd);
        event_base_loopbreak(base);
        return;
    }

    struct message *message = message_new(io);
    bufferevent_setcb(bev,
            server_read_callback,
            server_write_callback,
            server_event_callback, message);
    bufferevent_enable(bev, EV_READ);
    bufferevent_enable(bev, EV_WRITE);
}

static int io_server_init(struct io *io, const char *host, int port, enum IO_MODE mode)
{
    struct sockaddr_in sin;
    memset(&sin, 0, sizeof(sin));
    sin.sin_family = AF_INET;
    sin.sin_addr.s_addr = inet_addr(host);
    sin.sin_port = htons(port);

    struct event_base *base = event_base_new();
    struct evconnlistener *lev = evconnlistener_new_bind(base,
            server_accept_callback, io,
            LEV_OPT_REUSEABLE | LEV_OPT_CLOSE_ON_FREE, -1,
            (struct sockaddr *) &sin, sizeof(sin));

    debug_print(9, "host=%s, port=%d", host, port);
    if (lev == NULL) {
        debug_print(9, "bind() failed");
        return IO_FAILED;
    }
    io->base = base;
    return IO_OK;
}

static int io_server_write(struct io *io, void *data, uint32_t nbyte)
{
    if (bufferevent_write(io->bev, data, nbyte) != 0) {
        fprintf(stderr, "write error, v=('%p', %u)\n", data, nbyte);
        return IO_FAILED;
    }
    return IO_OK;
}

static int io_server_read(struct io *io, void *data, uint32_t nbyte)
{
    (void)io;(void)data;(void)nbyte;
    debug_print(0, "read");
    return IO_FAILED;
}

static int io_server_close(struct io *io)
{
    return IO_OK;
}

static const struct io_api server_api = {
    "server",
    io_server_init,
    io_server_read,
    io_server_write,
    io_server_close
};

int io_dispatch(struct io *io)
{
    assert(io->base);
    event_base_dispatch(io->base);
    io_close(io);
    return 0;
}

int main(int argc, char const* argv[])
{
    struct io *io = io_open("127.0.0.1", 12345, &server_api, IO_READ_WRITE);
    io_dispatch(io);
    return 0;
}

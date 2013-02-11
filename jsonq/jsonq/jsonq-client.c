#include "io.h"
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>

static int io_client_init(struct io *io, const char *host, int port, enum IO_MODE mode)
{
    struct sockaddr_in sin;
    memset(&sin, 0, sizeof(sin));
    sin.sin_family = AF_INET;
    sin.sin_port = htons(port);
    if(inet_pton(AF_INET, host, &sin.sin_addr)<=0) {
        fprintf(stderr, "inet_pton error occured\n");
        return IO_FAILED;
    }
    int sockfd = -1;
    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        fprintf(stderr, "Could not create socket \n");
        return IO_FAILED;
    }
    if(connect(sockfd, (struct sockaddr *)&sin, sizeof(sin)) < 0) {
        fprintf(stderr, "Connect Failed\n");
        return IO_FAILED;
    } 
    io->fd = sockfd;
    return IO_OK;
}

static int io_client_write(struct io *io, void *data, uint32_t nbyte)
{
    int res = -1;
    if ((res = write(io->fd, data, nbyte)) < 0) {
        fprintf(stderr, "write error, v=('%p', %u)\n", data, nbyte);
        return IO_FAILED;
    }
    return IO_OK;
}

static int io_client_read(struct io *io, void *data, uint32_t nbyte)
{
    int n = read(io->fd, data, nbyte);
    return (n >= 0) ? IO_OK : IO_FAILED;
}

static int io_client_close(struct io *io)
{
    close(io->fd);
    return IO_OK;
}

static const struct io_api client_api = {
    "client",
    io_client_init,
    io_client_read,
    io_client_write,
    io_client_close
};

int main(int argc, char const* argv[])
{
    struct io *io;
    if((io = io_open("127.0.0.1", 12345, &client_api, IO_READ_WRITE)) == NULL) {
        fprintf(stderr, "cannot open io stream\n");
        return 1;
    }
    io_write(io, "abcd", 4);
    char buffer[1024] = {};
    io_read(io, buffer, 1024);
    fprintf(stderr, "'%s'\n", buffer);
    io_close(io);
    return 0;
}

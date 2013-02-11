#include <event2/bufferevent.h>
#include <stdio.h>
#ifndef IO_H
#define IO_H

#define JSONQ_DEBUG 1
#define JSONQ_DEBUG_LEVEL 0
#define debug_print(level, ...) do {\
    if (level >= JSONQ_DEBUG_LEVEL) {\
        if (JSONQ_DEBUG) {\
            fprintf(stderr, "[%s:%d] ", __func__, __LINE__);\
            fprintf(stderr, ## __VA_ARGS__);\
            fprintf(stderr, "\n");\
            fflush(stderr);\
        }\
    }\
} while (0)

enum IO_STATUS {
    IO_OK = 0,
    IO_FAILED = -1
};

struct io_api;

enum IO_MODE {
    IO_NOP   = 0,
    IO_WRITE = 1 << 0,
    IO_READ  = 1 << 1,
    IO_READ_WRITE = IO_WRITE | IO_READ
};

struct io {
    const struct io_api *api;
    union {
        struct event_base *base;
        evutil_socket_t    fd;
        FILE *fp;
    };
    struct bufferevent *bev;
};

struct io_api {
    const char *name;
    int (*f_init) (struct io *io, const char *host, int port, enum IO_MODE mode);
    int (*f_read) (struct io *io, void *data, uint32_t nbyte);
    int (*f_write)(struct io *io, void *data, uint32_t nbyte);
    int (*f_close)(struct io *io);
};

struct io *io_open(const char *host, int port, const struct io_api *api, enum IO_MODE mode);
int io_close(struct io *io);
int io_write(struct io *io, void *data, uint32_t nbyte);
int io_read(struct io *io, void *data, uint32_t nbyte);
int io_dispatch(struct io *io);

#endif /* end of include guard */

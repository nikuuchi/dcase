#include "io.h"
#include <event2/event.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#ifdef __cplusplus
extern "C" {
#endif

struct io *io_open(const char *host, int port, const struct io_api *api, enum IO_MODE mode)
{
    struct io *io;
    io = calloc(1, sizeof(*io));
    io->api = api;
    if(api->f_init(io, host, port, mode) == IO_FAILED) {
        return NULL;
    }
    return io;
}

int io_close(struct io *io)
{
    io->api->f_close(io);
    bzero(io, sizeof(*io));
    free(io);
    return IO_OK;
}

int io_write(struct io *io, void *data, uint32_t nbyte)
{
    return io->api->f_write(io, data, nbyte);
}

int io_read(struct io *io, void *data, uint32_t nbyte)
{
    return io->api->f_read(io, data, nbyte);
}

#ifdef __cplusplus
} /* extern "C" */
#endif

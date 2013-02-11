#include "io.h"
#include <stdio.h>

static int io_file_init(struct io *io, const char *host, int port, enum IO_MODE mode)
{
    const char *io_mode = "";
    switch(mode) {
        case IO_READ:
            io_mode = "r";
            break;
        case IO_WRITE:
            io_mode = "w";
            break;
        default:
            return IO_FAILED;
    }
    io->fp = fopen(host, io_mode);
    return io->fp ? IO_OK : IO_FAILED;
}

static int io_file_write(struct io *io, void *data, uint32_t nbyte)
{
    size_t len = fwrite(data, nbyte, 1, io->fp);
    return len == nbyte ? IO_OK : IO_FAILED;
}

static int io_file_read(struct io *io, void *data, uint32_t nbyte)
{
    size_t len = fread(data, nbyte, 1, io->fp);
    return len == nbyte ? IO_OK : IO_FAILED;
}

static int io_file_close(struct io *io)
{
    fclose(io->fp);
    return IO_OK;
}

static const struct io_api file_api = {
    "file",
    io_file_init,
    io_file_read,
    io_file_write,
    io_file_close
};

int main(int argc, char const* argv[])
{
    struct io *io = io_open("./file.c", 0, &file_api, IO_READ);
    char buf[128];
    enum IO_STATUS status = io_read(io, buf, 128);
    fprintf(stderr, "%s\n", buf);
    return 0;
}

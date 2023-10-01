#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <limits.h>

int
main()
{
    int fn = open("/test.bin", O_TRUNC | O_CREAT | O_WRONLY, 0777);
    int in[1] = {0x93};
    write(fn, in, sizeof(in[0]));
    close(fn);
    return 0;
}


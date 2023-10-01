#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int
main(int argc, char **argv)
{
    int out = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0600);
    unsigned char res[4];
    unsigned in;
    while (scanf("%u", &in) == 1) {
        res[0] = (char) (in >> 20);
        res[1] = (char) (in << 12 >> 24);
        res[2] = (char) (in << 20 >> 28);
        res[3] = (char) (in << 24 >> 24);
        write(out, res, 4);
    }
    close(out);
    return 0;
}
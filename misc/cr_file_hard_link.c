
#include <unistd.h>

int
main(int argc, char **argv)
{
    symlink("/home/misha/Documents/file1", "/home/misha/Documents/f1");
    return 0;
}
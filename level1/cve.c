#include <stdio.h>
#include <unistd.h>
#include <string.h>

void restricted()
{
    printf("Should not happen!\n");
    _exit(42);
}

void fce(char *input)
{
    char buf[16] = { '\0' };
    printf("Hello! This is friendly program!\n");
    strcpy(buf, input);
    printf("%p\n", &fce);
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        puts("We need one argument at least");
        return 1;
    }

    fce(argv[1]);
}

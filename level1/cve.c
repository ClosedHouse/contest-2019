#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

void restricted()
{
    printf("Should not happen! Toto by se nemelo stat.\n");
    system("echo 'BU15_VQXSN' | tr '[a-zA-Z]' '[n-za-mN-ZA-M]'");
    _exit(64);
}

void fce(char *input)
{
    char buf[16] = { '\0' };
    printf("Hello! This is friendly program! Ahoj. Jsem kamaradsky program\n");
    strcpy(buf, input);
    printf("%p\n", &restricted);
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        puts("We need one argument at least. Je nutne zadat alespon jeden argument.");
        return 1;
    }

    fce(argv[1]);
}

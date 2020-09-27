#include <stdio.h>
#include <unistd.h>

int main() {
    char *name[] = {
        "/bin/systrace",
        "-i",
        "-A",
        "-E",
        "/var/log/systrace.log",
        "/bin/ksh",
        NULL
    };
    execvp(name[0], name);
    return 0;
}

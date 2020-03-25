#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

extern char **environ;

int run_cmd(const char *cmd)
{
    pid_t pid;
    const char *argv[] = {"sh", "-c", cmd, NULL};
    int status = posix_spawn(&pid, "/bin/sh", NULL, NULL, (char* const*)argv, environ);
    if (status == 0) {
        if (waitpid(pid, &status, 0) == -1) {
            perror("waitpid");
        }
    }
    return status;
}

int main()
{
    if (geteuid() != 0) {
        printf("Run this as root!\n");
        exit(1);
    }
    run_cmd("chmod 0755 /etc/rc.d/globalizefix");
    run_cmd("chown root:wheel /etc/rc.d/globalizefix");
    return 0;
}

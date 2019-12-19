#include <stdio.h>              /* printf(), perror() */
#include <stdlib.h>             /* exit() */
#include <sys/utsname.h>        /* uname() */
#include <sys/sysinfo.h>        /* sysinfo() */
#include <unistd.h>             /* getwpuid() */
#include <pwd.h>                /* geteuid() */

/* for colored output */
#define COLOR_RED          "\x1b[31m"
#define COLOR_GREEN        "\x1b[32m"
#define COLOR_YELLOW       "\x1b[33m"
#define COLOR_BLUE         "\x1b[34m"
#define COLOR_MAGENTA      "\x1b[35m"
#define COLOR_CYAN         "\x1b[36m"
#define COLOR_WHITE        "\x1b[37m"
#define COLOR_RESET        "\x1b[0m"

#define COLOR_RED_BOLD     "\x1b[31;1m"
#define COLOR_GREEN_BOLD   "\x1b[32;1m"
#define COLOR_YELLOW_BOLD  "\x1b[33;1m"
#define COLOR_BLUE_BOLD    "\x1b[34;1m"
#define COLOR_MAGENTA_BOLD "\x1b[35;1m"
#define COLOR_CYAN_BOLD    "\x1b[36;1m"
#define COLOR_WHITE_BOLD   "\x1b[37;1m"


int main()
{
    struct utsname uinfo;
    struct sysinfo sinfo;
    struct passwd *pw = getpwuid(geteuid());
    char *username;
    FILE *fp = fopen("/etc/os-release", "r");
    if (fp == NULL)
    {
        perror(COLOR_RED "Error: cannot read /etc/os-release." COLOR_RESET);
        exit(1);
    }
    char distroName[64];

    /* determine your distro name */
    fgets(distroName, sizeof(distroName), fp);
    for (int i = 0;i < (sizeof(distroName) - 5);i++)
    {
        if (distroName[i + 5] == '\n') distroName[i + 5] = '\0';
        else if (distroName[i + 5] == '"') distroName[i + 5] = ' ';
        distroName[i] = distroName[i + 5];

    }
    fclose(fp);
    if (distroName[0] == ' ')
        for (int i = 0;i < sizeof(distroName) - 1;i++)
            distroName[i] = distroName[i + 1];

    uname(&uinfo);                           /* initialize uname info structure */
    sysinfo(&sinfo);                         /* initialize system info (uptime, load average, ram, swap, number of processes) */
    username = pw -> pw_name;                /* get username */

    /* print all information */
    printf(COLOR_MAGENTA "%s@%s\n" COLOR_RESET
           COLOR_WHITE_BOLD "distro: " COLOR_RESET COLOR_MAGENTA "btw i use %s\n"        COLOR_RESET
           COLOR_WHITE_BOLD "kernel: " COLOR_RESET COLOR_MAGENTA "%s\n"                  COLOR_RESET
           COLOR_WHITE_BOLD "uptime: " COLOR_RESET COLOR_MAGENTA "%lih\n"                COLOR_RESET
           COLOR_WHITE_BOLD "ram:    " COLOR_RESET COLOR_MAGENTA "%luM/%luM/%luM/%luM\n" COLOR_RESET
           COLOR_WHITE_BOLD "swap:   " COLOR_RESET COLOR_MAGENTA "%luM/%luM\n"           COLOR_RESET
           COLOR_WHITE_BOLD "procs:  " COLOR_RESET COLOR_MAGENTA "%d\n"                  COLOR_RESET,
           username, uinfo.nodename,
           distroName,
           uinfo.release,
           sinfo.uptime / 60 / 60, /* uptime in hours */
           sinfo.totalram / 1024 / 1024, sinfo.freeram / 1024 / 1024, sinfo.sharedram / 1024 / 1024, sinfo.bufferram / 1024 / 1024, /* ram info in Mb */
           sinfo.totalswap / 1024 / 1024, sinfo.freeswap / 1024 / 1024, /* swap info in Mb */
           sinfo.procs          /* number of current processes */
        );

    return 0;
}

#include <stdio.h>              /* printf(), perror() */
#include <stdlib.h>             /* exit() */
#include <sys/utsname.h>        /* uname() */
#include <sys/sysinfo.h>        /* sysinfo() */
#include <unistd.h>             /* getwpuid() */
#include <pwd.h>                /* geteuid() */

/* for colored output */
#define COL_RED          "\x1b[31m"
#define COL_GREEN        "\x1b[32m"
#define COL_YELLOW       "\x1b[33m"
#define COL_BLUE         "\x1b[34m"
#define COL_MAGENTA      "\x1b[35m"
#define COL_CYAN         "\x1b[36m"
#define COL_WHITE        "\x1b[37m"
#define COL_RES          "\x1b[0m"

#define COL_RED_B        "\x1b[31;1m"
#define COL_GREEN_B      "\x1b[32;1m"
#define COL_YELLOW_B     "\x1b[33;1m"
#define COL_BLUE_B       "\x1b[34;1m"
#define COL_MAGENTA_B    "\x1b[35;1m"
#define COL_CYAN_B       "\x1b[36;1m"
#define COL_WHITE_B      "\x1b[37;1m"


int main()
{
    struct utsname uinfo;
    struct sysinfo sinfo;
    struct passwd *pw = getpwuid(geteuid());
    char *username;
    FILE *fp = fopen("/etc/os-release", "r");
    if (fp == NULL)
    {
        perror(COL_RED "Error: cannot read /etc/os-release." COL_RES);
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
    printf(COL_MAGENTA "%s@%s\n" COL_RES
           COL_WHITE_B "distro: " COL_RES COL_MAGENTA "btw i use %s\n"              COL_RES
           COL_WHITE_B "kernel: " COL_RES COL_MAGENTA "%s\n"                        COL_RES
           COL_WHITE_B "uptime: " COL_RES COL_MAGENTA "%lih\n"                      COL_RES
           COL_WHITE_B "ram:    " COL_RES COL_MAGENTA "%lum / %lum / %lum / %lum\n" COL_RES
           COL_WHITE_B "swap:   " COL_RES COL_MAGENTA "%lum / %lum\n"               COL_RES
           COL_WHITE_B "procs:  " COL_RES COL_MAGENTA "%d\n"                        COL_RES,
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

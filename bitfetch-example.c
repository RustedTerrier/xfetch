#include <stdio.h>              /* printf(), perror() */
#include <stdlib.h>             /* exit() */
#include <sys/utsname.h>        /* uname() */
#include <sys/sysinfo.h>        /* sysinfo() */
#include <unistd.h>             /* getwpuid() */
#include <pwd.h>                /* geteuid() */

/* for colored output */
#define COL_BLAC         "\x1b[30m"
#define COL_RED          "\x1b[31m"
#define COL_GREEN        "\x1b[32m"
#define COL_YELLOW       "\x1b[33m"
#define COL_BLUE         "\x1b[34m"
#define COL_MAGENTA      "\x1b[35m"
#define COL_CYAN         "\x1b[36m"
#define COL_WHITE        "\x1b[37m"

#define COL_RES          "\x1b[0m"

#define COL_BLACK_B      "\x1b[30;1m"
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
    char *distroName = "Example Linux";

    uname(&uinfo);                           /* initialize uname info structure */
    sysinfo(&sinfo);                         /* initialize system info (uptime, load average, ram, swap, number of processes) */
    username = pw -> pw_name;                /* get username */

    /* print all information */
    fprintf(stdout,
            "\n"
            COL_CYAN "+------------+ " "%s" COL_WHITE   "@"        COL_CYAN "%s\n"                        COL_RES /* user and host name */
            COL_CYAN "|Example logo| "      COL_WHITE_B "distro: " COL_CYAN "%s\n"                        COL_RES /* name of your linux distro */
            COL_CYAN "|Example logo| "      COL_WHITE_B "kernel: " COL_CYAN "%s\n"                        COL_RES /* kernel release */
            COL_CYAN "|Example logo| "      COL_WHITE_B "uptime: " COL_CYAN "%lih %lim\n"                 COL_RES /* uptime */
            COL_CYAN "|Example logo| "      COL_WHITE_B "ram:    " COL_CYAN "%lum / %lum / %lum / %lum\n" COL_RES /* ram info in Mb */
            COL_CYAN "|Example logo| "      COL_WHITE_B "swap:   " COL_CYAN "%lum / %lum\n"               COL_RES /* swap info in Mb */
            COL_CYAN "+------------+ "      COL_WHITE_B "procs:  " COL_CYAN "%d\n"                        COL_RES /* number of current processes */
            "\n",
            username, uinfo.nodename,
            distroName,
            uinfo.release,
            sinfo.uptime / 60 / 60, (sinfo.uptime / 60) - (sinfo.uptime / 60 / 60 * 60),
            sinfo.totalram / 1024 / 1024, sinfo.freeram / 1024 / 1024, sinfo.sharedram / 1024 / 1024, sinfo.bufferram / 1024 / 1024,
            sinfo.totalswap / 1024 / 1024, sinfo.freeswap / 1024 / 1024,
            sinfo.procs
        );

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <pwd.h>
#include <sys/utsname.h>
#include <sys/sysinfo.h>
#include <unistd.h>

int main()
{
    struct utsname uinfo;
    struct sysinfo sinfo;
    struct passwd *pw = getpwuid(geteuid());
    double loads[3] = {0};

    uname(&uinfo);          // kernel info
    sysinfo(&sinfo);        // get uptime, ram/swap info and number of current processes
    getloadavg(loads, 3);   // get load average

    /* print all information */
    fprintf(stdout,

            "\n"
            COL_DIST_B LOGO_1L "%s" COL_FG_B "@"                 COL_DIST "%s\n"                        COL_RES
            COL_DIST_B LOGO_2L      COL_FG_B "distro:  " COL_RES COL_DIST DISTRONAME"\n"                COL_RES
            COL_DIST_B LOGO_3L      COL_FG_B "kernel:  " COL_RES COL_DIST "%s\n"                        COL_RES
            COL_DIST_B LOGO_4L      COL_FG_B "uptime:  " COL_RES COL_DIST "%lih %lim\n"                 COL_RES
            COL_DIST_B LOGO_5L      COL_FG_B "loadavg: " COL_RES COL_DIST "%.2f %.2f %.2f\n"            COL_RES
            COL_DIST_B LOGO_6L      COL_FG_B "shell:   " COL_RES COL_DIST "%s\n"                        COL_RES
            COL_DIST_B LOGO_7L      COL_FG_B "ram:     " COL_RES COL_DIST "%lum / %lum / %lum / %lum\n" COL_RES
            COL_DIST_B LOGO_8L      COL_FG_B "swap:    " COL_RES COL_DIST "%lum / %lum\n"               COL_RES
            COL_DIST_B LOGO_9L      COL_FG_B "procs:   " COL_RES COL_DIST "%d\n"                        COL_RES
            "\n",

            pw -> pw_name, uinfo.nodename,                                                                              // username and hostname
            uinfo.release,                                                                                              // kernel
            sinfo.uptime / 3600, (sinfo.uptime / 60) - (sinfo.uptime / 3600 * 60),                                      // uptime in hours and minutes
            loads[0], loads[1], loads[2],                                                                               // load average
            pw -> pw_shell,                                                                                             // user's defautlt shell
            sinfo.totalram / 1048576, sinfo.freeram / 1048576, sinfo.sharedram / 1048576, sinfo.bufferram / 1048576,    // ram info
            sinfo.totalswap / 1048576, sinfo.freeswap / 1048576,                                                        // swap info
            sinfo.procs                                                                                                 // number of current processes

        );

    return 0;
}

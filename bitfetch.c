#include <stdio.h>
#include <stdlib.h>
#include <pwd.h>
#include <sys/utsname.h>
#include <sys/sysinfo.h>
#include <unistd.h>

#if BITFETCH_GENTOO
#include "distros/gentoo.h"
#elif BITFETCH_ARCH
#include "distros/arch.h"
#elif BITFETCH_CRUX
#include "distros/crux.h"
#elif BITFETCH_UBUNTU
#include "distros/ubuntu.h"
#elif BITFETCH_VOID
#include "distros/void.h"
#else
#include "distros/linux.h"
#endif

int main()
{
    struct utsname uinfo;
    struct sysinfo sinfo;
    struct passwd *pw = getpwuid(geteuid());
    double loads[3] = {0};

    uname(&uinfo);
    sysinfo(&sinfo);
    getloadavg(loads, 3);

    /* print all information */
    fprintf(stdout,
            "\n"
            COL_DIST  LOGO_1L "%s" COL_RES "@"         COL_DIST "%s\n"                        COL_RES
            COL_DIST  LOGO_2L      COL_RES "distro:  " COL_DIST DISTRONAME"\n"                COL_RES
            COL_DIST  LOGO_3L      COL_RES "kernel:  " COL_DIST "%s\n"                        COL_RES
            COL_DIST  LOGO_4L      COL_RES "uptime:  " COL_DIST "%lih %lim\n"                 COL_RES
            COL_DIST  LOGO_5L      COL_RES "loadavg: " COL_DIST "%.2f %.2f %.2f\n"            COL_RES
            COL_DIST  LOGO_6L      COL_RES "shell:   " COL_DIST "%s\n"                        COL_RES
            COL_DIST  LOGO_7L      COL_RES "ram:     " COL_DIST "%lum / %lum / %lum / %lum\n" COL_RES
            COL_DIST  LOGO_8L      COL_RES "swap:    " COL_DIST "%lum / %lum\n"               COL_RES
            COL_DIST  LOGO_9L      COL_RES "procs:   " COL_DIST "%d\n"                        COL_RES

            "\n",
            pw -> pw_name, uinfo.nodename,
            uinfo.release,
            sinfo.uptime / 3600, (sinfo.uptime / 60) - (sinfo.uptime / 3600 * 60),
            loads[0], loads[1], loads[2],
            pw -> pw_shell,
            sinfo.totalram / 1048576, sinfo.freeram / 1048576, sinfo.sharedram / 1048576, sinfo.bufferram / 1048576,
            sinfo.totalswap / 1048576, sinfo.freeswap / 1048576,
            sinfo.procs
        );

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <pwd.h>
#include <unistd.h>
#include <sys/utsname.h>
#include <sys/sysinfo.h>
#include <string.h>

#ifdef X
#include <X11/Xlib.h>
#endif

int main(int argc, char *argv[])
{
    if (argc >= 2) {
        if (strcmp("-h", argv[1]) != 0 && strcmp("--help", argv[1]) != 0)
            printf(COL_RED "error: unrecognized option \'%s\'\n" COL_RES, argv[1]);
        printf("bitfetch - simple cli system information tool written in C\n\n"
               "usage:\n"
               "    " COL_DIST_B "`bitfetch`"    COL_RES "    will show your distro logo and name, kernel release, uptime, load avearage, current shell, ram/swap info and number of processes\n"
               "    " COL_DIST_B "`bitfetch -h`" COL_RES " will show this message\n\n"
               "currently supported distros: "  SUPPORTED_DISTRO_LIST "\n\n"
               "version " VERSION "\n");
        return 1;
    }
    struct utsname uinfo;
    struct sysinfo sinfo;
    struct passwd *pw = getpwuid(geteuid());
    double loads[3] = {0};

#ifdef X
    Display *dpy;
    XWindowAttributes root_attr;
#endif

    uname(&uinfo);          // kernel info
    sysinfo(&sinfo);        // get uptime, ram/swap info and number of current processes
    getloadavg(loads, 3);   // get load average

#ifdef X
    dpy = XOpenDisplay(NULL);
    if (dpy == NULL) fprintf(stderr, COL_RED_B "error: " COL_RES " can't open display %s\n", XDisplayName(NULL));
    else XGetWindowAttributes(dpy, DefaultRootWindow(dpy), &root_attr); // get root window attributes
#endif

    /* print all information */
    printf(
            "\n"
                    DISTRO_LOGO
            "\x1b[" DISTRO_LOGO_LINE_COUNT "A"
            "\x1b[" DISTRO_LOGO_WIDTH "C"  "%s" COL_FG_B "@"                    COL_DIST "%s\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "distro      " COL_RES COL_DIST DISTRO_NAME "\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "kernel      " COL_RES COL_DIST "%s %s\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "uptime      " COL_RES COL_DIST "%lih %lim\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "loadavg     " COL_RES COL_DIST "%.2f %.2f %.2f\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "shell       " COL_RES COL_DIST "%s\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "terminal    " COL_RES COL_DIST "%s\n"
#ifdef X
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "resolution  " COL_RES COL_DIST "%dx%d\n"
#endif
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "ram         " COL_RES COL_DIST "%lum / %lum\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "swap        " COL_RES COL_DIST "%lum / %lum\n"
            "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "procs       " COL_RES COL_DIST "%d\n"
                    COL_RES
            "\n",

            pw -> pw_name, uinfo.nodename,
            uinfo.release, uinfo.machine,
            sinfo.uptime / 3600, (sinfo.uptime / 60) - (sinfo.uptime / 3600 * 60),
            loads[0], loads[1], loads[2],
            pw -> pw_shell,
            getenv("TERM"),
#ifdef X
            dpy ? root_attr.width : 0, dpy ? root_attr.height : 0,
#endif
            (sinfo.totalram - sinfo.freeram)   / 1048576, sinfo.totalram  / 1048576,
            (sinfo.totalswap - sinfo.freeswap) / 1048576, sinfo.totalswap / 1048576,
            sinfo.procs
    );
    return 0;
}

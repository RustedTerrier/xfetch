#include <stdio.h>
#include <stdlib.h>
#include <pwd.h>
#include <unistd.h>
#include <sys/utsname.h>
#include <sys/sysinfo.h>
#include <string.h>
#include <libgen.h>
#include <pthread.h>

#ifdef X
#include <X11/Xlib.h>
#endif
#ifdef XINERAMA
#include <X11/extensions/Xinerama.h>
#endif

#ifndef SI_LOAD_SHIFT
#define SI_LOAD_SHIFT 16
#endif

#define LOADAVG_SHIFT (1.0 / (1 << SI_LOAD_SHIFT))

#ifdef X
    Display *dpy;
#ifdef XINERAMA
    XineramaScreenInfo *xinfo;
    char resolution[128]; // на всякий случай 128 :D
    char _tmp_buffer[24];
    int number_of_screens = 0;
#else
    XWindowAttributes root_attr;
#endif
#endif

#ifdef SHOW_PKG_NUMBER
    FILE *fp;
    unsigned long pkg_count = 0;
#endif

#ifdef X
void *get_resolution(void *argv);
#endif

#ifdef SHOW_PKG_NUMBER
void *get_pkg(void *argv);
#endif

int main(int argc, char *argv[])
{
    if (argc >= 2) {
        if (strcmp("-h", argv[1]) != 0 && strcmp("--help", argv[1]) != 0)
            printf(COL_RED "error: unrecognized option \'%s\'\n" COL_RES, argv[1]);
        printf("xfetch - simple cli system information tool written in C\n\n"
               "usage:\n"
               "    " COL_DIST_B "`xfetch`"    COL_RES "    will show your distro logo and name,\n"
                                           "                  kernel release, uptime, load avearage,\n"
                                           "                  current shell, screen resolutions,\n"
                                           "                  number of installed packages and\n"
                                           "                  ram/swap info\n\n"
               "    " COL_DIST_B "`xfetch -h`" COL_RES " will show this message\n\n"
               "version " VERSION "\n");
        return 1;
    }

    /* variable difinitions */
    struct utsname uinfo;
    struct sysinfo sinfo;
    struct passwd *pw;

#ifdef X
    pthread_t get_resolution_thread;
#endif
#ifdef SHOW_PKG_NUMBER
    pthread_t get_pkg_thread;
#endif

    /* gathering information */
    uname(&uinfo);
    sysinfo(&sinfo);
    pw = getpwuid(geteuid());

#ifdef SHOW_PKG_NUMBER
    pthread_create(&get_pkg_thread, NULL, get_pkg, NULL);
    pthread_join(get_pkg_thread, NULL);
#endif
#ifdef X
    pthread_create(&get_resolution_thread, NULL, get_resolution, NULL);
    pthread_join(get_resolution_thread, NULL);
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
#ifdef XINERAMA
        "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "resolution  " COL_RES COL_DIST "%s\n"
#else
        "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "resolution  " COL_RES COL_DIST "%dx%d\n"
#endif
#endif
#ifdef SHOW_PKG_NUMBER
        "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "packages    " COL_RES COL_DIST "%lu\n"
#endif
        "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "ram         " COL_RES COL_DIST "%lum / %lum\n"
        "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "swap        " COL_RES COL_DIST "%lum / %lum\n"
        "\x1b[" DISTRO_LOGO_WIDTH "C"       COL_FG_B "procs       " COL_RES COL_DIST "%d\n"
        COL_RES
        "\n",
        pw -> pw_name, uinfo.nodename,
        uinfo.release, uinfo.machine,
        sinfo.uptime / 3600, (sinfo.uptime / 60) - (sinfo.uptime / 3600 * 60),
        sinfo.loads[0] * LOADAVG_SHIFT, sinfo.loads[1] * LOADAVG_SHIFT, sinfo.loads[2] * LOADAVG_SHIFT,
        basename(pw -> pw_shell),
        getenv("TERM"),
#ifdef X
#ifdef XINERAMA
        dpy ? resolution : "0x0",
#else
        dpy ? root_attr.width : 0, dpy ? root_attr.height : 0,
#endif
#endif
#ifdef SHOW_PKG_NUMBER
        pkg_count,
#endif
        (sinfo.totalram - sinfo.freeram) / 1048576, sinfo.totalram / 1048576,
        (sinfo.totalswap - sinfo.freeswap) / 1048576, sinfo.totalswap / 1048576,
        sinfo.procs
        );
#ifdef XINERAMA
    if (dpy)
        XFree(xinfo);
#endif
    return 0;
}

#ifdef X
void *get_resolution(void *argv) {
    dpy = XOpenDisplay(NULL); // get current display
    if (dpy == NULL) fprintf(stderr, COL_RED_B "error: " COL_RES " can't open display %s\n", XDisplayName(NULL));
#ifdef XINERAMA
    else {
        xinfo  = XineramaQueryScreens(dpy, &number_of_screens);
        sprintf(resolution, "%dx%d", xinfo[0].width, xinfo[0].height);
        for (int i = 1;i < number_of_screens;i++) {
                sprintf(_tmp_buffer, ", %dx%d", xinfo[i].width, xinfo[i].height);
                strcat(resolution, _tmp_buffer);
        }
    }
#else
    else {
        XGetWindowAttributes(dpy, XDefaultRootWindow(dpy), &root_attr); // get root window attributes
    }
#endif
}
#endif

#ifdef SHOW_PKG_NUMBER
void *get_pkg(void *argv) {
    fp = popen(PKG_NUMBER_CMD, "r");
    if (fp == NULL)
        fprintf(stderr, COL_RED_B "error: " COL_RES "failed to get number of installed packages\n");
    for (char c = getc(fp);c != EOF;c = getc(fp))
        if (c == '\n')
            pkg_count++;
    pclose(fp);
}
#endif

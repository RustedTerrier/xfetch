#ifndef BITFETCH_H
#define BITFETCH_H

#include "colors.h"

#define DISTRO_NAME "Generic Linux"
#define COL_DIST    COL_WHITE
#define COL_DIST_B  COL_WHITE_B

#define DISTRO_LOGO COL_DIST_B "\n"              \
                               "      ___\n"     \
                               "     (.· |\n"    \
                               "     (<> |\n"    \
                               "    / __  \\\n"  \
                               "   ( /  \\ /|\n" \
                               "  _/\\ __)/_)\n" \
                               "  \\/-____\\/\n" \

#ifdef SHOW_PKG_NUMBER
#undef SHOW_PKG_NUMBER
#endif

#define DISTRO_LOGO_LINE_COUNT "8"
#define DISTRO_LOGO_WIDTH      "16"

#endif

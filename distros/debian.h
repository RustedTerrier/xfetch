#ifndef XFETCH_H
#define XFETCH_H

#include "colors.h"

#define DISTRO_NAME "Debian Linux"
#define COL_DIST    COL_RED
#define COL_DIST_B  COL_RED_B

#define DISTRO_LOGO COL_DIST_B "\n"           \
                               "      _____\n"   \
                               "     /  __ \\\n" \
                               "    |  /    |\n" \
                               "    |  \\___-\n" \
                               "    -_\n"        \
                               "      --_\n"

#define PKG_NUMBER_CMD "dpkg -l"

#define DISTRO_LOGO_LINE_COUNT "7"
#define DISTRO_LOGO_WIDTH      "16"

#endif

#ifndef BITFETCH_H
#define BITFETCH_H

#include "colors.h"

#define DISTRO_NAME "Artix Linux"
#define COL_DIST    COL_BLUE
#define COL_DIST_B  COL_BLUE_B

#define DISTRO_LOGO COL_DIST_B "\n"                 \
                               "       /\\\n"       \
                               "      /  \\\n"      \
                               "     /`'.,\\\n"     \
                               "    /     ',\n"     \
                               "   /      ,`\\\n"   \
                               "  /   ,.'`.  \\\n"  \
                               " /.,'`     `'.\\\n"

#define PKG_NUMBER_CMD "pacman -Qq | wc -l"

#define DISTRO_LOGO_LINE_COUNT "8"
#define DISTRO_LOGO_WIDTH      "16"

#endif

#ifndef COLORS_H
#define COLORS_H

#define COL_BLACK        "\x1b[30m"
#define COL_RED          "\x1b[31m"
#define COL_GREEN        "\x1b[32m"
#define COL_YELLOW       "\x1b[33m"
#define COL_BLUE         "\x1b[34m"
#define COL_MAGENTA      "\x1b[35m"
#define COL_CYAN         "\x1b[36m"
#define COL_WHITE        "\x1b[37m"

#if COL_DISABLE_BOLD

#define COL_BLACK_B      "\x1b[30m"
#define COL_RED_B        "\x1b[31m"
#define COL_GREEN_B      "\x1b[32m"
#define COL_YELLOW_B     "\x1b[33m"
#define COL_BLUE_B       "\x1b[34m"
#define COL_MAGENTA_B    "\x1b[35m"
#define COL_CYAN_B       "\x1b[36m"
#define COL_WHITE_B      "\x1b[37m"
#define COL_FG_B         "\x1b[m"

#else

#define COL_BLACK_B      "\x1b[30;1m"
#define COL_RED_B        "\x1b[31;1m"
#define COL_GREEN_B      "\x1b[32;1m"
#define COL_YELLOW_B     "\x1b[33;1m"
#define COL_BLUE_B       "\x1b[34;1m"
#define COL_MAGENTA_B    "\x1b[35;1m"
#define COL_CYAN_B       "\x1b[36;1m"
#define COL_WHITE_B      "\x1b[37;1m"
#define COL_FG_B         "\x1b[;1m"

#endif

#define COL_RES          "\x1b[0m"

#endif

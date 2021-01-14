CC      ?= gcc
CFLAGS  ?= -O3 -pipe
PREFIX  ?= /usr/local/
LIBS     = -lpthread

X        ?= YES
XINERAMA ?= YES
PKG      ?= YES

MINIMAL  ?= NO

XFETCH_VERSION = 1.0

# TODO: сделать нормально
ifeq ($(ID),)
	OS_RELEASE ?= $(shell [ -f /etc/os-release ] && echo "/etc/os-release" || echo "/usr/lib/os-release")
	include ${OS_RELEASE}
endif

ifeq ($(MINIMAL),YES)
	X = NO
	XINERAMA = NO
	PKG = NO
	SWAP = NO
endif

ifeq ($(X),YES)
	CFLAGS += -DX
	LIBS += $(shell pkg-config --libs x11)
ifeq ($(XINERAMA),YES)
	CFLAGS += -DXINERAMA
	LIBS += $(shell pkg-config --libs xinerama)
endif
endif

ifeq ($(PKG),YES)
	CFLAGS += -DSHOW_PKG_NUMBER
endif

all: xfetch

.PHONY: list-vars
list-vars:
	@echo "CC = ${CC}"
	@echo "CFLAGS = ${CFLAGS}"
	@echo "PREFIX = ${PREFIX}"
	@echo "ID = ${ID}"
	@echo "VERSION = ${XFETCH_VERSION}"
	@echo "X11 = ${X}"
	@echo "XINERAMA = ${XINERAMA}"
	@echo "PKG = ${PKG}"
	@[ "${LIBS}" ] && \
		echo "LIBS = ${LIBS}" || true
	@[ "${DESTDIR}" ] && \
		echo "DESTDIR = ${DESTDIR}" || true
	@echo ""

.PHONY: xfetch-build
xfetch-build: list-vars
	@${CC} xfetch.c ${CFLAGS} ${LIBS} -o xfetch \
		-DSUPPORTED_DISTRO_LIST="\"${DISTROS}\"" -DVERSION="\"${XFETCH_VERSION}\"" \
		-include distros/${ID}.h
	@echo "xfetch.c + distros/${ID}.h -> xfetch"

.PHONY: xfetch
xfetch:
	@case "${ID}" in \
		"void"          | "gentoo"      | "ubuntu" | "arch"                | \
		"linuxmint"     | "manjaro"     | "fedora" | "opensuse-tumbleweed" | \
		"opensuse-leap" | "elementary"  | "kiss"   | "artix"               | \
		"crux"          | "manjaro-arm" | "debian" | "solus"               | \
		"ataraxia") \
			make xfetch-build ID="${ID}" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
		*) \
			make xfetch-build ID="generic" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
	esac

.PHONY: install
install:
	@mkdir -p ${DESTDIR}${PREFIX}/bin 2> /dev/null || true
	@cp -p xfetch ${DESTDIR}${PREFIX}/bin/xfetch
	@echo "xfetch -> ${DESTDIR}${PREFIX}/bin/xfetch"

.PHONY: uninstall
uninstall:
	@rm ${DESTDIR}${PREFIX}/bin/xfetch -v

.PHONY: clean
clean:
	@rm xfetch -v

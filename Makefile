CC      ?= gcc
CFLAGS  ?= -O3 -pipe
PREFIX  ?= /usr/local/

X        ?= YES
XINERAMA ?= YES
PKG      ?= YES
SWAP     ?= YES

MINIMAL  ?= NO

BITFETCH_VERSION = 3.0

ifeq ($(ID),)
	include /etc/os-release
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

ifeq ($(SWAP),YES)
	CFLAGS += -DSHOW_SWAP
endif

all: bitfetch

.PHONY: list-vars
list-vars:
	@echo "CC = ${CC}"
	@echo "CFLAGS = ${CFLAGS}"
	@echo "PREFIX = ${PREFIX}"
	@echo "ID = ${ID}"
	@echo "VERSION = ${BITFETCH_VERSION}"
	@echo "X11 = ${X}"
	@echo "XINERAMA = ${XINERAMA}"
	@echo "SWAP = ${SWAP}"
	@echo "PKG = ${PKG}"
	@[ "${LIBS}" ] && \
		echo "LIBS = ${LIBS}" || true
	@[ "${DESTDIR}" ] && \
		echo "DESTDIR = ${DESTDIR}" || true
	@echo ""

.PHONY: bitfetch-build
bitfetch-build: list-vars
	@${CC} bitfetch.c ${CFLAGS} ${LIBS} -o bitfetch \
		-DSUPPORTED_DISTRO_LIST="\"${DISTROS}\"" -DVERSION="\"${BITFETCH_VERSION}\"" \
		-include distros/${ID}.h
	@echo "bitfetch.c + distros/${ID}.h -> bitfetch"

.PHONY: bitfetch
bitfetch:
	@case "${ID}" in \
		"void"          | "gentoo"      | "ubuntu" | "arch"                | \
		"linuxmint"     | "manjaro"     | "fedora" | "opensuse-tumbleweed" | \
		"opensuse-leap" | "elementary"  | "kiss"   | "artix"               | \
		"crux"          | "manjaro-arm" | "debian" | "solus"               | \
		"ataraxia") \
			make bitfetch-build ID="${ID}" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
		*) \
			make bitfetch-build ID="generic" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
	esac

.PHONY: install
install:
	@mkdir -p ${DESTDIR}${PREFIX}/bin 2> /dev/null || true
	@cp -p bitfetch ${DESTDIR}${PREFIX}/bin/bitfetch
	@echo "bitfetch -> ${DESTDIR}${PREFIX}/bin/bitfetch"

.PHONY: uninstall
uninstall:
	@rm ${DESTDIR}${PREFIX}/bin/bitfetch -v

.PHONY: clean
clean:
	@rm bitfetch -v

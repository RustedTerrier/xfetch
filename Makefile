CC      ?= gcc
CFLAGS  ?= -O3 -pipe
PREFIX  ?= /usr/local/

X ?= YES
XINERAMA ?= YES

DISTROS = kiss, gentoo, arch, void, manjaro, mint, fedora, opensuse, elementary and ubuntu

BITFETCH_VERSION = 2.2

include /etc/os-release

ifeq ($(X),YES)
	CFLAGS += -DX
	LIBS += $(shell pkg-config --libs x11)
ifeq ($(XINERAMA),YES)
	CFLAGS += -DXINERAMA
	LIBS += $(shell pkg-config --libs xinerama)
endif
endif

.PHONY: help
help:
	@echo "'make help' to show this message."
	@echo "'make bitfetch ID=generic' to build generic version of bitfetch"
	@echo "'make bitfetch' to try building bitfetch with ${NAME}'s logo or with generic logo (supported now: ${DISTROS})"
	@echo "'make CC=clang bitfetch' to build bitfetch with clang instead of gcc"
	@echo "'make CFLAGS=\"-DCOL_DISABLE_BOLD\" bitfetch' to build bitfetch's version without bold colors"
	@echo "'make install' to install bitfetch's binary to /usr/local/bin/ (you need to build it before)"
	@echo "'make PREFIX=${HOME} install' to install bitfetch's binary to ${HOME}/bin"
	@echo "'make bitfetch X=1' to build bitfetch with X11 support (depends on Xlib)"
	@echo "'make clean' to remove bitfetch's binary"

.PHONY: list-vars
list-vars:
	@echo "CC = ${CC}"
	@echo "CFLAGS = ${CFLAGS}"
	@echo "PREFIX = ${PREFIX}"
	@echo "ID = ${ID}"
	@echo "VERSION = ${BITFETCH_VERSION}"
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
		"void" | "gentoo" | "ubuntu" | "arch" | "linuxmint" | "manjaro" | "fedora" | "opensuse-tumbleweed" | "opensuse-leap" | "elementary" | "kiss") \
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

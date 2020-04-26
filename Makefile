CC      ?= gcc
CFLAGS  ?= -O3 -pipe
PREFIX  ?= /usr/local/
OS      ?= linux

DISTROS           = gentoo, arch, void, manjaro, mint, fedora, opensuse, elementary and ubuntu (also openbsd and freebsd)
BITFETCH_VERSION  = 1.1

ifeq      (${OS}, linux)
	include /etc/os-release
	EXTRA_FLAGS = -include linux-distros/${ID}.h
else ifeq (${OS}, openbsd)
	ID   = openbsd
	NAME = OpenBSD
else ifeq (${OS}, freebsd)
	ID   = freebsd
	NAME = FreeBSD
endif

.PHONY: help
help:
	@echo "'make help' to show this message."
	@echo "'make bitfetch ID=generic' to build generic version of bitfetch"
	@echo "'make bitfetch' to try building bitfetch with ${NAME}'s logo or with generic logo"
	@echo "'make CC=clang bitfetch' to build bitfetch with clang instead of gcc"
	@echo "'make CFLAGS=\"-DCOL_DISABLE_BOLD\" bitfetch' to build bitfetch's version without bold colors"
	@echo "'make install' to build and install bitfetch's binary to /usr/local/bin/"
	@echo "'make PREFIX=${HOME} install' to install bitfetch's binary to ${HOME}/bin"
	@echo "'make clean' to remove bitfetch's binary"

.PHONY: list-vars
list-vars:
	@echo "CC = ${CC}"
	@echo "CFLAGS = ${CFLAGS}"
	@echo "PREFIX = ${PREFIX}"
	@echo "ID = ${ID}"
	@[ ${DESTDIR} ] && \
		echo "DESTDIR = ${DESTDIR}" || true
	@echo ""

.PHONY: bitfetch
bitfetch: list-vars
	@${CC} bitfetch.c ${CFLAGS} -o bitfetch \
		-DSUPPORTED_DISTRO_LIST="\"${DISTROS}\"" -DVERSION="\"${BITFETCH_VERSION}\"" -DID="\"${ID}\"" \
		-include ${OS}.h \
		${EXTRA_FLAGS}
	@echo "bitfetch.c + ${OS}.h -> bitfetch"

.PHONY: install
install: bitfetch
	@mkdir -p ${DESTDIR}${PREFIX}/bin 2> /dev/null || true
	@cp -p bitfetch ${DESTDIR}${PREFIX}/bin/bitfetch
	@echo "bitfetch -> ${DESTDIR}${PREFIX}/bin/bitfetch"

.PHONY: uninstall
uninstall:
	@rm ${DESTDIR}${PREFIX}/bin/bitfetch -v

.PHONY: clean
clean:
	@rm bitfetch -v

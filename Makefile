CC      ?= gcc
CFLAGS  ?= -O3 -pipe
PREFIX  ?= /usr/local/

DISTROS  = gentoo, arch, void, manjaro, mint, fedora, opensuse, elementary and ubuntu
VERSION  = 1.1

include /etc/os-release

.PHONY: help
help:
	@echo "'make help' to show this message."
	@echo "'make bitfetch ID=generic' to build generic version of bitfetch"
	@echo "'make bitfetch' to try building bitfetch with ${NAME}'s logo or with generic logo (supported now: ${DISTROS})"
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

.PHONY: bitfetch-build
bitfetch-build: list-vars
	@${CC} bitfetch.c ${CFLAGS} -o bitfetch \
		-DSUPPORTED_DISTRO_LIST="\"${DISTROS}\"" -DVERSION="\"${VERSION}\"" \
		-include distros/${ID}.h
	@echo "bitfetch.c + distros/${ID}.h -> bitfetch"

.PHONY: bitfetch
bitfetch:
	@case "${ID}" in \
		"void" | "gentoo" | "ubuntu" | "arch" | "linuxmint" | "manjaro" | "fedora" | "opensuse-tumbleweed" | "opensuse-leap" | "elementary") \
			make bitfetch-build ID="${ID}" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
		*) \
			make bitfetch-build ID="generic" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
	esac

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

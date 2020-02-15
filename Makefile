CC = gcc
CFLAGS = -O3
PREFIX = /usr/local/

include /etc/os-release

.PHONY: bitfetch
help:
	@echo " 'make help' to show this message.\n" \
		"'make bitfetch-generic' to build generic version of bitfetch\n" \
		"'make bitfetch' to try building bitfetch with ${NAME}'s logo or with generic logo (supported now: gentoo, arch, crux, void and ubuntu)\n" \
		"'make CC=clang bitfetch-generic' to build generic version of bitfetch with clang instead of gcc\n" \
		"'make bitfetch-<distro>' to build bitfetch with <distro>'s logo\n" \
		"'make CFLAGS=\"-DCOL_DISABLE_BOLD\" bitfetch' to build bitfetch's version without bold colors\n" \
		"'make install' to build and install bitfetch's binary to /usr/local/bin/\n" \
		"'make PREFIX=${HOME} install' to install bitfetch's binary to ${HOME}/bin\n" \
		"'make clean' to remove bitfetch's binary"

.PHONY: bitfetch
list-vars:
	@echo "CC = ${CC}"
	@echo "CFLAGS = ${CFLAGS}"
	@echo "PREFIX = ${PREFIX}"
	@echo "ID = ${NAME}"
	@echo ""

.PHONY: bitfetch-gentoo
bitfetch-gentoo: list-vars
	@${CC} bitfetch.c -include distros/gentoo.h ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/gentoo.h -> bitfetch"

.PHONY: bitfetch-arch
bitfetch-arch: list-vars
	@${CC} bitfetch.c -include distros/arch.h ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/arch.h -> bitfetch"

.PHONY: bitfetch-ubuntu
bitfetch-ubuntu: list-vars
	@${CC} bitfetch.c -include distros/ubuntu.h ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/ubuntu.h -> bitfetch"

.PHONY: bitfetch-crux
bitfetch-crux: list-vars
	@${CC} bitfetch.c -include distros/crux.h ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/crux.h -> bitfetch"

.PHONY: bitfetch-generic
bitfetch-generic: list-vars
	@${CC} bitfetch.c -include distros/generic.h ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/generic.h -> bitfetch"

.PHONY: bitfetch-void
bitfetch-void: list-vars
	@${CC} bitfetch.c -include distros/void.h ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/void.h -> bitfetch"

.PHONY: bitfetch
bitfetch:
	@case "${ID}" in\
		"void" | "gentoo" | "ubuntu" | "crux" | "arch") make -s bitfetch-${ID} CC="${CC}" PREFIX="${PREFIX}" CFLAGS="${CFLAGS}" ;; \
		*)   make -s bitfetch-generic CC="${CC}" PREFIX="${PREFIX}" CFLAGS="${CFLAGS}" ;; \
	esac

.PHONY: install
install: bitfetch
	@cp bitfetch ${PREFIX}/bin/bitfetch
	@mkdir ${PREFIX}/bin 2> /dev/null || true
	@echo "bitfetch -> ${PREFIX}/bin/bitfetch"

.PHONY: clean
clean:
	@rm bitfetch -v

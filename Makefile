CC = gcc
CFLAGS = -O3
PREFIX = /usr/local/

help:
	@echo "'make help' to show this message."
	@echo "'make bitfetch-generic' to build generic version of bitfetch"
	@echo "'make CC=clang bitfetch-generic' to build generic version of bitfetch with clang instead of gcc"
	@echo "'make bitfetch-<distro>' to build bitfetch with <distro>-logo (distro can be: gentoo, arch, ubuntu, crux or void)"
	@echo "'make CFLAGS=\"-DCOL_DISABLE_BOLD\" bitfetch' to build bitfetch's version without bold colors"
	@echo "'make install' to install bitfetch's binary to /usr/local/bin/ (warning: you must build it before installing)"
	@echo "'make PREFIX=${HOME} install' to install bitfetch's binary to ${HOME}/bin"
	@echo "'make clean' to remove bitfetch's binary"

bitfetch-gentoo:
	@${CC} bitfetch.c -DBITFETCH_GENTOO ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/gentoo.h -> bitfetch"

bitfetch-arch:
	@${CC} bitfetch.c -DBITFETCH_ARCH ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/arch.h -> bitfetch"

bitfetch-ubuntu:
	@${CC} bitfetch.c -DBITFETCH_UBUNTU ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/ubuntu.h -> bitfetch"

bitfetch-crux:
	@${CC} bitfetch.c -DBITFETCH_CRUX ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/crux.h -> bitfetch"

bitfetch-generic:
	@${CC} bitfetch.c ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/generic.h -> bitfetch"

bitfetch-void:
	@${CC} bitfetch.c -DBITFETCH_VOID ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/void.h -> bitfetch"

install:
	@cp bitfetch ${PREFIX}/bin/bitfetch
	@mkdir ${PREFIX}/bin 2> /dev/null || true
	@echo "bitfetch -> ${PREFIX}/bin/bitfetch"

clean:
	@rm bitfetch -v

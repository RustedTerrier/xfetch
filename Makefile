CC = gcc
CFLAGS = -O3
PREFIX = /usr/local/

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

bitfetch-linux:
	@${CC} bitfetch.c -DBITFETCH_LINUX ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/linux.h -> bitfetch"

bitfetch-void:
	@${CC} bitfetch.c -DBITFETCH_VOID ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/void.h -> bitfetch"

install:
	@cp bitfetch ${PREFIX}/bin/bitfetch
	@mkdir ${PREFIX}/bin 2> /dev/null || true
	@echo "bitfetch -> ${PREFIX}/bin/bitfetch"

clean:
	rm bitfetch

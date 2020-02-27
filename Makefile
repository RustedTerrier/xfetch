CC = gcc
CFLAGS = -O3
PREFIX = /usr/local/

include /etc/os-release

.PHONY: bitfetch
help:
	@echo "'make help' to show this message.\n"
	@echo "'make bitfetch ID=generic' to build generic version of bitfetch\n"
	@echo "'make bitfetch' to try building bitfetch with ${NAME}'s logo or with generic logo (supported now: gentoo, arch, void and ubuntu)\n"
	@echo "'make CC=clang bitfetch' to build bitfetch with clang instead of gcc\n"
	@echo "'make CFLAGS=\"-DCOL_DISABLE_BOLD\" bitfetch' to build bitfetch's version without bold colors\n"
	@echo "'make install' to build and install bitfetch's binary to /usr/local/bin/\n"
	@echo "'make PREFIX=${HOME} install' to install bitfetch's binary to ${HOME}/bin\n"
	@echo "'make clean' to remove bitfetch's binary"

.PHONY: bitfetch
list-vars:
	@echo "CC = ${CC}"
	@echo "CFLAGS = ${CFLAGS}"
	@echo "PREFIX = ${PREFIX}"
	@echo "ID = ${ID}"
	@echo ""

.PHONY: bitfetch-build
bitfetch-build: list-vars
	@${CC} bitfetch.c -include distros/${ID}.h ${CFLAGS} -o bitfetch
	@echo "bitfetch.c + distros/${ID}.h -> bitfetch"

.PHONY: bitfetch
bitfetch:
	@case "${ID}" in \
		"void" | "gentoo" | "ubuntu" | "arch") make bitfetch-build ID="${ID}" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
		*) make bitfetch-build ID="generic" CC="${CC}" CFLAGS="${CFLAGS}" PREFIX="${PREFIX}" -s ;; \
	esac

.PHONY: install
install: bitfetch
	@cp bitfetch ${PREFIX}/bin/bitfetch
	@mkdir ${PREFIX}/bin 2> /dev/null || true
	@echo "bitfetch -> ${PREFIX}/bin/bitfetch"

.PHONY: clean
clean:
	@rm bitfetch -v

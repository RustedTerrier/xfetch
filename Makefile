PREFIX = /usr/local

all:
	@echo "Run \`make build-gentoo\` to build bitfetch-gentoo.c"
	@echo "Run \`make build-example\` to build bitfetch-example.c"
	@echo "Run \`make build-all\` to build all bitfetch-*.c files"
	@echo ""
	@echo "Use bitfetch-example.c to create a bitfetch's version for another linux distro."

build-gentoo:
	@gcc -O3 bitfetch-gentoo.c -o bitfetch-gentoo
	@echo "gcc bitfetch-gentoo.c -> bitfetch-gentoo"

build-example:
	@gcc -O3 bitfetch-example.c -o bitfetch-example
	@echo "gcc bitfetch-example.c -> bitfetch-example"

build-all: build-gentoo build-example

.PHONY: install
install: all
	@cp bitfetch ${PREFIX}/bin/bitfetch -v

.PHONY: uninstall
uninstall:
	@rm ${PREFIX}/bin/bitfetch -v

.PHONY: clean
clean:
	@rm bitfetch-gentoo bitfetch-example -v || true

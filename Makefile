PREFIX = /usr/local

all:
	@echo "Run \`make build-ubuntu\` to build avfetch-ubuntu.c files"
	@echo "Run \`make build-gentoo\` to build bitfetch-gentoo.c"
	@echo "Run \`make build-example\` to build bitfetch-example.c"
	@echo "Run \`make build-all\` to build all bitfetch-*.c files"
	@echo ""
	@echo "Use bitfetch-example.c to create a bitfetch's version for another linux distro."

build-ubuntu:
	@gcc -O3 avfetch-ubuntu.c -o avfetch-ubuntu
	@echo "gcc avfetch-ubuntu.c -> avfetch-ubuntu"

build-gentoo:
	@gcc -O3 bitfetch-gentoo.c -o bitfetch-gentoo
	@echo "gcc bitfetch-gentoo.c -> bitfetch-gentoo"

build-example:
	@gcc -O3 bitfetch-example.c -o bitfetch-example
	@echo "gcc bitfetch-example.c -> bitfetch-example"

build-all: build-gentoo build-example avfetch-ubuntu


.PHONY: install-ubuntu
install-ubuntu: build-ubuntu
	@cp avfetch-ubuntu ${PREFIX}/bin/bitfetch -v

.PHONY: install-gentoo
install-gentoo: build-gentoo
	@cp bitfetch-gentoo ${PREFIX}/bin/bitfetch -v

.PHONY: install-example
install-example: build-example
	@cp bitfetch-example ${PREFIX}/bin/bitfetch -v

.PHONY: uninstall
uninstall:
	@rm ${PREFIX}/bin/bitfetch -v

.PHONY: clean
clean:
	@rm avfetch-ubuntu bitfetch-gentoo bitfetch-example -v || true

PREFIX = /usr/local

all:
	@echo "Run \`make build-gentoo\` to build bitfetch-gentoo.c"
	@echo "Run \`make build-ubuntu\` to build bitfetch-ubuntu.c"
	@echo "Run \`make build-crux\` to build bitfetch-crux.c"
	@echo "Run \`make build-void\` to build bitfetch-void.c"
	@echo "Run \`make build-example\` to build bitfetch-example.c"
	@echo "Run \`make build-all\` to build all bitfetch-*.c files"
	@echo ""
	@echo "Use bitfetch-example.c to create a bitfetch's version for another linux distro."

build-void:
	@gcc -O3   bitfetch-void.c -o bitfetch-void
	@echo "gcc bitfetch-void.c -> bitfetch-void"

build-crux:
	@gcc -O3   bitfetch-crux.c -o bitfetch-crux
	@echo "gcc bitfetch-crux.c -> bitfetch-crux"

build-ubuntu:
	@gcc -O3   bitfetch-ubuntu.c -o bitfetch-ubuntu
	@echo "gcc bitfetch-ubuntu.c -> bitfetch-ubuntu"

build-gentoo:
	@gcc -O3   bitfetch-gentoo.c -o bitfetch-gentoo
	@echo "gcc bitfetch-gentoo.c -> bitfetch-gentoo"

build-example:
	@gcc -O3   bitfetch-example.c -o bitfetch-example
	@echo "gcc bitfetch-example.c -> bitfetch-example"

build-all: build-gentoo build-example bitfetch-ubuntu build-void build-example

.PHONY: install-void
install-void: build-void
	@cp bitfetch-void ${PREFIX}/bin/bitfetch -v

.PHONY: install-crux
install-crux: build-crux
	@cp bitfetch-crux ${PREFIX}/bin/bitfetch -v

.PHONY: install-ubuntu
install-ubuntu: build-ubuntu
	@cp bitfetch-ubuntu ${PREFIX}/bin/bitfetch -v

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
	@rm bitfetch-ubuntu bitfetch-gentoo bitfetch-example bitfetch-crux -v || true


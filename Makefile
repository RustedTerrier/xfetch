PREFIX = /usr/local
CC = gcc

help:
	@echo "Run \`make build-gentoo\`  to build bitfetch-gentoo.c"
	@echo "Run \`make build-ubuntu\`  to build bitfetch-ubuntu.c"
	@echo "Run \`make build-crux\`    to build bitfetch-crux.c"
	@echo "Run \`make build-void\`    to build bitfetch-void.c"
	@echo "Run \`make build-example\` to build bitfetch-example.c"
	@echo "Run \`make build-all\`     to build all bitfetch-*.c files"
	@echo ""
	@echo "Run \`make install-gentoo\`  to install bitfetch-gentoo"
	@echo "Run \`make install-ubuntu\`  to install bitfetch-ubuntu"
	@echo "Run \`make install-crux\`    to install bitfetch-crux"
	@echo "Run \`make install-void\`    to install bitfetch-void"
	@echo "Run \`make install-example\` to install bitfetch-example"
	@echo ""
	@echo "Use bitfetch-example.c to create a bitfetch's version for another linux distro."

build-void:
	@${CC} -O3   bitfetch-void.c -o bitfetch-void
	@echo "${CC} bitfetch-void.c -> bitfetch-void"

build-crux:
	@${CC} -O3   bitfetch-crux.c -o bitfetch-crux
	@echo "${CC} bitfetch-crux.c -> bitfetch-crux"

build-ubuntu:
	@${CC} -O3   bitfetch-ubuntu.c -o bitfetch-ubuntu
	@echo "${CC} bitfetch-ubuntu.c -> bitfetch-ubuntu"

build-gentoo:
	@${CC} -O3   bitfetch-gentoo.c -o bitfetch-gentoo
	@echo "${CC} bitfetch-gentoo.c -> bitfetch-gentoo"

build-example:
	@${CC} -O3   bitfetch-example.c -o bitfetch-example
	@echo "${CC} bitfetch-example.c -> bitfetch-example"

build-all: build-gentoo build-example build-ubuntu build-void build-example

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
	@rm bitfetch-ubuntu bitfetch-gentoo bitfetch-example bitfetch-crux bitfetch-void -v || true


PREFIX = /usr/local

all: build

build:
	gcc -O3 bitfetch.c -o bitfetch

.PHONY: install
install:
	cp bitfetch ${PREFIX}/bin/bitfetch -v

.PHONY: uninstall
uninstall:
	rm ${PREFIX}/bin/bitfetch -v

.PHONY: clean
clean:
	rm bitfetch -v

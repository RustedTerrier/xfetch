# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 flag-o-matic

DESCRIPTION="Simple fetch written in C"
HOMEPAGE="https://gitlab.com/bit9tream/bitfetch"
EGIT_REPO_URI="https://gitlab.com/bit9tream/bitfetch.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="disable-bold"

src_compile() {
	use disable-bold && append-flags "-DCOL_DISABLE_BOLD"
	emake -j1 ID=gentoo bitfetch-build
}

src_install() {
	emake -j1 DESTDIR="${D}" PREFIX="/usr" install
}

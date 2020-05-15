# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 flag-o-matic

DESCRIPTION="Simple fetch written in C"
HOMEPAGE="https://gitlab.com/bit9tream/bitfetch"
EGIT_REPO_URI="https://gitlab.com/bit9tream/bitfetch.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="disable-bold X xinerama +show-swap +show-pkg-number"

REQUIRED_USE="
	xinerama? ( X )
"

DEPEND="
	X? ( x11-libs/libX11 )
	xinerama? ( x11-libs/libXinerama )
"

src_compile() {
	use disable-bold && append-flags "-DCOL_DISABLE_BOLD"
	emake -j1 ID=gentoo bitfetch-build X="$(usex X YES NO)" XINERAMA="$(usex xinerama YES NO)" SWAP="$(usex show-swap YES NO)" PKG="$(usex show-pkg-number YES NO)"
}

src_install() {
	emake -j1 DESTDIR="${D}" PREFIX="/usr" install
}

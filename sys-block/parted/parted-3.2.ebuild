# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/parted/parted-3.2.ebuild,v 1.9 2014/11/11 10:49:14 ago Exp $

EAPI=5
inherit eutils

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="http://www.gnu.org/software/parted"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 ~s390 ~sh sparc ~x86"
IUSE="+debug device-mapper nls readline selinux static-libs"
RESTRICT="test"

# specific version for gettext needed
# to fix bug 85999
RDEPEND="
	>=sys-fs/e2fsprogs-1.27
	>=sys-libs/ncurses-5.7-r7
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	readline? ( >=sys-libs/readline-5.2 )
	selinux? ( sys-libs/libselinux )
"
DEPEND="
	${RDEPEND}
	nls? ( >=sys-devel/gettext-0.12.1-r2 )
	virtual/pkgconfig
"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.2-devmapper.patch
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable device-mapper) \
		$(use_enable nls) \
		$(use_enable selinux) \
		$(use_enable static-libs static) \
		$(use_with readline) \
		--disable-rpath \
		--disable-silent-rules
}

DOCS=( AUTHORS BUGS ChangeLog NEWS README THANKS TODO doc/{API,FAT,USER.jp} )

src_install() {
	default
	prune_libtool_files
}

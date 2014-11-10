# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pip/pip-1.2-r2.ebuild,v 1.1 2014/11/02 13:43:04 zlogene Exp $

EAPI=5

inherit eutils perl-app

DESCRIPTION="Wrapper around programs that don't support stdin/stdout"
HOMEPAGE="http://membled.com/work/apps/pip/"
SRC_URI="http://membled.com/work/apps/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_install() {
	perl-module_src_install
	mv "${ED}"/usr/bin/{pip,gpip} || die 'rename failed'
}

pkg_postinst() {
	perl-module_pkg_postinst
	ewarn "To avoid collisions with dev-python/pip executable file of this package was renamed to 'gpip'"
}
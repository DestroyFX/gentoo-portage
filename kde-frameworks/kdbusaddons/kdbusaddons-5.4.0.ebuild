# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kdbusaddons/kdbusaddons-5.4.0.ebuild,v 1.1 2014/11/14 11:01:34 mrueg Exp $

EAPI=5

VIRTUALDBUS_TEST="true"
inherit kde5

DESCRIPTION="Framework for registering services and applications according to freedesktop standards"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE="nls X"

RDEPEND="
	dev-qt/qtdbus:5
	X? ( dev-qt/qtx11extras:5 )
"
DEPEND="${RDEPEND}
	nls? ( dev-qt/linguist-tools:5 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X Qt5X11Extras)
	)

	kde5_src_configure
}

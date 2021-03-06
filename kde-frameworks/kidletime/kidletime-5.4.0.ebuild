# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kidletime/kidletime-5.4.0.ebuild,v 1.1 2014/11/14 11:01:36 mrueg Exp $

EAPI=5

KDE_TEST="false"
inherit kde5

DESCRIPTION="Framework for detection and notification of device idle time"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXext
	x11-libs/libxcb
"
DEPEND="${RDEPEND}"

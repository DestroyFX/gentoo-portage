# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-strigi-analyzer/kdesdk-strigi-analyzer-4.14.3.ebuild,v 1.1 2014/11/16 12:21:27 alexxy Exp $

EAPI=5

KMNAME="kdesdk-strigi-analyzers"
inherit kde4-base

DESCRIPTION="kdesdk: strigi plugins"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"

if [[ ${KDE_BUILD_TYPE} != live ]] ; then
	S="${WORKDIR}/${KMNAME}-${PV}"
fi

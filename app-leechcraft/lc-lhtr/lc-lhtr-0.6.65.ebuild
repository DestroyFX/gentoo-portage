# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-lhtr/lc-lhtr-0.6.65.ebuild,v 1.1 2014/04/10 17:57:50 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft HTML Text editoR component"

SLOT="0"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	app-text/htmltidy
	dev-qt/qtwebkit:4
	"
RDEPEND="${DEPEND}"

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/deriving/deriving-0.7.ebuild,v 1.1 2014/10/29 14:22:34 aballier Exp $

EAPI=5

OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="A deriving library for Ocsigen"
HOMEPAGE="http://github.com/ocsigen/deriving"
SRC_URI="http://github.com/ocsigen/deriving/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-ml/type-conv-108:=
	dev-ml/optcomp:=
	dev-ml/findlib:=
"
DEPEND="${RDEPEND}
	dev-ml/oasis"

DOCS=( CHANGES README.md )
oasis_configure_opts="--enable-tc"
OASIS_SETUP_COMMAND="./setup.exe"

src_configure() {
	emake setup.exe
	oasis_src_configure
}

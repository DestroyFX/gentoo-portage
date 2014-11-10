# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ecb/ecb-2.41_pre20140215.ebuild,v 1.1 2014/11/10 08:21:22 ulm Exp $

EAPI=5

inherit elisp eutils readme.gentoo

DESCRIPTION="Source code browser for Emacs"
HOMEPAGE="http://ecb.sourceforge.net/"
# snapshot of https://github.com/alexott/ecb.git
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="java"

DEPEND="java? ( app-emacs/jde )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
SITEFILE="70${PN}-gentoo.el"
DOC_CONTENTS="ECB is autoloaded in site-gentoo.el. Add the line
	\n\t(require 'ecb)
	\nto your ~/.emacs file to enable all features on Emacs startup."

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.32-gentoo.patch"
	sed -i -e "s:@PF@:${PF}:" ecb-help.el || die "sed failed"
}

src_compile() {
	local loadpath="" sl=${EPREFIX}${SITELISP}
	if use java; then
		loadpath="${sl}/elib ${sl}/jde ${sl}/jde/lisp"
	fi

	emake LOADPATH="${loadpath}"
}

src_install() {
	elisp_src_install

	insinto "${SITEETC}/${PN}"
	doins -r ecb-images

	doinfo info-help/ecb.info*
	dohtml html-help/*.html
	dodoc CYCLE_PROPOSAL NEWS README RELEASE_NOTES TODO
}
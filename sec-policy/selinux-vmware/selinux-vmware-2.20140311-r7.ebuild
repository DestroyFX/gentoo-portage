# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-vmware/selinux-vmware-2.20140311-r7.ebuild,v 1.1 2014/11/01 17:26:16 swift Exp $
EAPI="5"

IUSE=""
MODS="vmware"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for vmware"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-memcached/selinux-memcached-9999.ebuild,v 1.3 2014/11/01 16:13:33 swift Exp $
EAPI="5"

IUSE=""
MODS="memcached"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for memcached"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

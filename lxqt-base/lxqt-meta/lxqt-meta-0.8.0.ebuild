# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-meta/lxqt-meta-0.8.0.ebuild,v 1.1 2014/11/08 17:54:51 jauhien Exp $

EAPI=5

DESCRIPTION="Meta ebuild for LXQt, the Lightweight Desktop Environment"
HOMEPAGE="http://lxqt.org/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="admin icons lightdm lximage -minimal +policykit powermanagement sddm ssh-askpass"

S="${WORKDIR}"

RDEPEND="
	>=lxde-base/lxmenu-data-0.1.2
	~lxqt-base/lxqt-about-${PV}
	~lxqt-base/lxqt-common-${PV}
	~lxqt-base/lxqt-config-${PV}
	~lxqt-base/lxqt-notificationd-${PV}
	~lxqt-base/lxqt-panel-${PV}
	~lxqt-base/lxqt-qtplugin-${PV}
	~lxqt-base/lxqt-runner-${PV}
	~lxqt-base/lxqt-session-${PV}
	~x11-misc/pcmanfm-qt-${PV}
	admin? (
		~app-admin/lxqt-admin-${PV} )
	icons? (
		>=lxde-base/lxde-icon-theme-0.5 )
	lightdm? (
		x11-misc/lightdm )
	lximage? (
		>=media-gfx/lximage-qt-0.3.0 )
	!minimal? (
		x11-wm/openbox
		>=x11-misc/obconf-qt-0.1.0_p20141029 )
	policykit? (
		~lxqt-base/lxqt-policykit-${PV}
		|| ( sys-auth/consolekit[policykit(-)]
			sys-apps/systemd[policykit(-)] ) )
	powermanagement? (
		~lxqt-base/lxqt-powermanagement-${PV} )
	sddm? (
		>=x11-misc/sddm-0.10.0 )
	ssh-askpass? (
		~net-misc/lxqt-openssh-askpass-${PV} )
"

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils pax-utils user systemd

DESCRIPTION="Rapid spam filtering system"
SRC_URI="https://rspamd.com/downloads/${P}.tar.xz"
HOMEPAGE="https://github.com/vstakhov/rspamd"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fann +jit libressl"

RDEPEND="!libressl? ( dev-libs/openssl:0[-bindist] )
		libressl? ( dev-libs/libressl:0 )
		fann? ( sci-mathematics/fann )
		jit? (
			dev-libs/libpcre[jit]
			dev-lang/luajit:2
		)
		!jit? (
			dev-libs/libpcre[-jit]
			>=dev-lang/lua-5.1:0
		)
		dev-libs/libevent
		dev-db/sqlite:3
		dev-libs/glib:2
		dev-libs/gmime
		dev-util/ragel
		sys-apps/file
		virtual/libiconv"
DEPEND="dev-util/ragel
		${RDEPEND}"

QA_MULTILIB_PATHS="usr/lib/rspamd/.*"

pkg_setup() {
	enewgroup rspamd
	enewuser rspamd -1 -1 /var/lib/rspamd rspamd
}

src_configure() {
	local mycmakeargs=(
		-DCONFDIR=/etc/rspamd
		-DRUNDIR=/var/run/rspamd
		-DDBDIR=/var/lib/rspamd
		-DLOGDIR=/var/log/rspamd
		-DENABLE_LUAJIT=$(usex jit ON OFF)
		-DENABLE_FANN=$(usex fann ON OFF)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	pax-mark m "${ED}"/usr/bin/rspamadm-*
	pax-mark m "${ED}"/usr/bin/rspamd-*
	newinitd "${FILESDIR}/rspamd.init-r3" rspamd

	dodir /var/lib/rspamd
	dodir /var/log/rspamd

	fowners rspamd:rspamd /var/lib/rspamd /var/log/rspamd

	insinto /etc/logrotate.d
	newins "${FILESDIR}/rspamd.logrotate" rspamd

	systemd_newunit rspamd.service rspamd.service
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils flag-o-matic linux-info linux-mod

DESCRIPTION="High performance PPTP, PPPoE and L2TP server"
HOMEPAGE="http://accel-ppp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc ipoe postgres radius shaper snmp valgrind"

RDEPEND="postgres? ( dev-db/postgresql:* )
	snmp? ( net-analyzer/net-snmp )
	dev-libs/libpcre
	dev-libs/openssl:0"
DEPEND="${RDEPEND}
	valgrind? ( dev-util/valgrind )"
PDEPEND="net-dialup/ppp-scripts"

DOCS=( README )

CONFIG_CHECK="~L2TP ~PPPOE ~PPTP"

REQUIRED_USE="valgrind? ( debug )"

pkg_setup() {
	if use ipoe; then
		linux-mod_pkg_setup
		set_arch_to_kernel
	else
		linux-info_pkg_setup
	fi
}

src_prepare() {
	sed -i  -e "/mkdir/d" \
		-e "/echo/d" \
		-e "s: RENAME accel-ppp.conf.dist::" accel-pppd/CMakeLists.txt || die 'sed on accel-pppd/CMakeLists.txt failed'
	sed -i -e '/modules_install/d' drivers/ipoe/CMakeLists.txt || die 'sed on drivers/ipoe/CMakeLists.txt failed'

	# Bug #549918
	append-ldflags -Wl,-z,lazy

	cmake-utils_src_prepare
}

src_configure() {
	local libdir="$(get_libdir)"
	# There must be also dev-libs/tomcrypt (TOMCRYPT) as crypto alternative to OpenSSL
	local mycmakeargs=(
		-DLIB_PATH_SUFFIX="${libdir#lib}"
		-DBUILD_IPOE_DRIVER="$(usex ipoe)"
		-DBUILD_PPTP_DRIVER=no
		-DCRYPTO=OPENSSL
		-DLOG_PGSQL="$(usex postgres)"
		-DMEMDEBUG="$(usex debug)"
		-DNETSNMP="$(usex snmp)"
		-DRADIUS="$(usex radius)"
		-DSHAPER="$(usex shaper)"
		-DVALGRIND="$(usex valgrind)"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	if use ipoe; then
		local MODULE_NAMES="ipoe(accel-ppp:${BUILD_DIR}/drivers/ipoe/driver)"
		linux-mod_src_install
	fi

	cmake-utils_src_install

	use doc && dodoc -r rfc

	if use snmp; then
		insinto /usr/share/snmp/mibs
		doins accel-pppd/extra/net-snmp/ACCEL-PPP-MIB.txt
	fi

	newinitd "${FILESDIR}"/${PN}.initd ${PN}d
	newconfd "${FILESDIR}"/${PN}.confd ${PN}d

	dodir /var/log/accel-ppp
}

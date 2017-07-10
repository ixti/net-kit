# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.7.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Wiki using happstack, git or darcs, and pandoc"
HOMEPAGE="http://gitit.net"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+network-uri +plugins"

RDEPEND=">=app-text/pandoc-1.12.4:=[profile?] <app-text/pandoc-1.18:=[profile?]
	>=dev-haskell/aeson-0.7:=[profile?] <dev-haskell/aeson-0.12:=[profile?]
	>=dev-haskell/base64-bytestring-0.1:=[profile?] <dev-haskell/base64-bytestring-1.1:=[profile?]
	>=dev-haskell/blaze-html-0.4:=[profile?] <dev-haskell/blaze-html-0.9:=[profile?]
	>=dev-haskell/configfile-1:=[profile?] <dev-haskell/configfile-1.2:=[profile?]
	>=dev-haskell/feed-0.3.6:=[profile?] <dev-haskell/feed-0.4:=[profile?]
	>=dev-haskell/filestore-0.6:=[profile?] <dev-haskell/filestore-0.7:=[profile?]
	>=dev-haskell/happstack-server-7.0:=[profile?] <dev-haskell/happstack-server-7.5:=[profile?]
	>=dev-haskell/highlighting-kate-0.5.0.1:=[profile?] <dev-haskell/highlighting-kate-0.7:=[profile?]
	>=dev-haskell/hoauth2-0.4.2:=[profile?] <dev-haskell/hoauth2-0.6:=[profile?]
	>=dev-haskell/hslogger-1:=[profile?] <dev-haskell/hslogger-1.3:=[profile?]
	>=dev-haskell/hstringtemplate-0.6:=[profile?] <dev-haskell/hstringtemplate-0.9:=[profile?]
	>=dev-haskell/http-4000.0:=[profile?] <dev-haskell/http-4000.4:=[profile?]
	>=dev-haskell/http-client-tls-0.2.2:=[profile?] <dev-haskell/http-client-tls-0.3:=[profile?]
	>=dev-haskell/http-conduit-2.1.4:=[profile?] <dev-haskell/http-conduit-2.2:=[profile?]
	>=dev-haskell/json-0.4:=[profile?] <dev-haskell/json-0.10:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/old-locale-1:=[profile?]
	dev-haskell/old-time:=[profile?]
	>=dev-haskell/pandoc-types-1.12.3:=[profile?] <dev-haskell/pandoc-types-1.17:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/random:=[profile?]
	>=dev-haskell/recaptcha-0.1:=[profile?]
	dev-haskell/safe:=[profile?]
	>dev-haskell/sha-1:=[profile?] <dev-haskell/sha-1.7:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/syb:=[profile?]
	>=dev-haskell/tagsoup-0.13:=[profile?] <dev-haskell/tagsoup-0.14:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/uri-0.1:=[profile?] <dev-haskell/uri-0.2:=[profile?]
	>=dev-haskell/url-2.1:=[profile?] <dev-haskell/url-2.2:=[profile?]
	>=dev-haskell/utf8-string-0.3:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-haskell/uuid-1.3:=[profile?] <dev-haskell/uuid-1.4:=[profile?]
	dev-haskell/xhtml:=[profile?]
	>=dev-haskell/xml-1.3.5:=[profile?]
	>=dev-haskell/xss-sanitize-0.3:=[profile?] <dev-haskell/xss-sanitize-0.4:=[profile?]
	>=dev-haskell/zlib-0.5:=[profile?] <dev-haskell/zlib-0.7:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	network-uri? ( >=dev-haskell/network-2.6:=[profile?]
			>=dev-haskell/network-uri-2.6:=[profile?] <dev-haskell/network-uri-2.7:=[profile?] )
	!network-uri? ( >=dev-haskell/network-2:=[profile?] <dev-haskell/network-2.6:=[profile?] )
	plugins? ( dev-haskell/ghc-paths:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag network-uri network-uri) \
		$(cabal_flag plugins plugins)
}

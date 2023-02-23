EAPI=8

DESCRIPTION="A modern and transparent way to use Windows VST2, VST3 and CLAP plugins on Linux"
HOMEPAGE="https://github.com/robbert-vdh/yabridge/"
SRC_URI="https://github.com/robbert-vdh/yabridge/releases/download/${PV}/yabridge-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

S="${WORKDIR}/yabridge"

src_compile() { :; }

src_install() {
	dobin "${S}"/yabridgectl
	dobin "${S}"/*.exe
	dobin "${S}"/yabridge*.so
	dolib.so "${S}"/libyabridge*.so
}

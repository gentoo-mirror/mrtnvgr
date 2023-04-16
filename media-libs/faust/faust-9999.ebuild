EAPI=8

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/grame-cncm/faust.git"
	inherit git-r3
else
	SRC_URI="https://github.com/grame-cncm/faust/releases/download/${PV}/${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="A realtime audio utility library for C++"
HOMEPAGE="https://github.com/grame-cncm/faust"

LICENSE="GPL-2"
SLOT="0"

src_install() {
	emake PREFIX="${T}" install
}

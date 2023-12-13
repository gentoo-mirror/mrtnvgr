EAPI=8

inherit font

DESCRIPTION="Cascadia Code + Nerd Fonts"
HOMEPAGE="https://github.com/adam7/delugia-code"
SRC_URI="https://github.com/adam7/delugia-code/releases/download/v${PV}/${PN}.zip"
KEYWORDS=""

LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}"
FONT_SUFFIX="ttf"

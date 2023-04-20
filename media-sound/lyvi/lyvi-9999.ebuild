EAPI=8

# DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

EGIT_REPO_URI="https://github.com/ok100/lyvi.git"
inherit git-r3

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Command-line lyrics (and more!) viewer"
HOMEPAGE="http://ok100.github.io/lyvi/"

LICENSE="WTFPL"
SLOT="0"

DEPEND="
	media-libs/glyr
"

PATCHES=(
	"${FILESDIR}/0001-fix-pip-errors.patch"
)

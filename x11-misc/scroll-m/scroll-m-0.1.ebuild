EAPI=8

inherit toolchain-funcs

DESCRIPTION="Scroll back buffer for a terminal like st"
HOMEPAGE="https://tools.suckless.org/scroll"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.suckless.org/scroll"
else
	SRC_URI="https://dl.suckless.org/tools/scroll-${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~ppc64 ~riscv ~x86"
fi

LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="mousewheel"

S="${WORKDIR}/scroll-${PV}"

src_prepare() {
	if use mousewheel; then
		PATCHES+=("${FILESDIR}/0001-enable-mouse-wheel-keybindings.patch")
	fi
	default

	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^STLDFLAGS/s|= .*|= $(LDFLAGS) $(LIBS)|g' \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die
	sed -i \
		-e '/tic/d' \
		Makefile || die
}

src_configure() {
	sed -i \
		-e "s|pkg-config|$(tc-getPKG_CONFIG)|g" \
		config.mk || die

	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install

	dodoc README
}

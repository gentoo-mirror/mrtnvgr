EAPI=8

inherit desktop toolchain-funcs

DESCRIPTION="Simple terminal implementation for X"
HOMEPAGE="https://st.suckless.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.suckless.org/st"
else
	SRC_URI="https://dl.suckless.org/st/st-${PV}.tar.gz"
	KEYWORDS=""
fi

LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="+xresources +scroll +boxdraw +hidecursor"

RDEPEND="
	>=sys-libs/ncurses-6.0:0=
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXft
	~x11-terms/st-terminfo-${PV}
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/st-${PV}"

PATCHESDIR="${FILESDIR}/${PV}"
PATCHES=(
	${PATCHESDIR}/
)

src_prepare() {
	use xresources && PATCHES+=("${PATCHESDIR}/xresources/")
	use scroll && PATCHES+=("${PATCHESDIR}/scroll/")
	use boxdraw && PATCHES+=("${PATCHESDIR}/boxdraw/")
	use boxdraw && use xresources && PATCHES+=("${PATCHESDIR}/boxdraw+xresources/")
	use hidecursor && PATCHES+=("${PATCHESDIR}/hidecursor/")
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

	dodoc TODO

	make_desktop_entry st simpleterm utilities-terminal 'System;TerminalEmulator;' ''

}

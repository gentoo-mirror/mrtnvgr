EAPI=8

DESCRIPTION="(MASKED) Advanced cross-platform rhythm game focused on keyboard play"

HOMEPAGE="https://github.com/etternagame/etterna/"

inherit wrapper

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/etternagame/etterna.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/etternagame/etterna/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=" "

RDEPEND="
>=dev-libs/openssl-1.1.1q
x11-libs/libXrandr
net-misc/curl
media-libs/mesa
media-libs/glu
media-libs/libogg
media-sound/pulseaudio
"

DEPEND="
>=dev-util/cmake-3.14.0
${RDEPEND}
"

src_configure() {
	mkdir build && cd build
	cmake -DCMAKE_BUILD_TYPE=Release -DWITH_CRASHPAD=OFF -G "Unix Makefiles" ..
}

src_compile() {
	cd build && emake
}

src_install() {

	# Project without crashpad cant be installed with emake install, issue #1208
	# cd build && emake install DESTDIR="${D}"

	GAMEDIR="/usr/$(get_libdir)/${PN}"

	# Cleaning up build cache
	rm -rf build
	rm -rf src
	rm -rf CMake
	rm -f CMakeLists.txt

	dodir ${GAMEDIR}

	# Installing docs
	dodoc -r Docs/*
	rm -rf Docs

	make_wrapper Etterna ${GAMEDIR}/Etterna ${GAMEDIR}

	exeinto ${GAMEDIR}
	doexe Etterna

	insinto ${GAMEDIR}
	doins -r *

	# Add access to regular users
	fperms 777 ${GAMEDIR}
	fowners -R :wheel ${GAMEDIR}
	fowners :wheel ${GAMEDIR}

	fperms 755 ${GAMEDIR}/Etterna

	keepdir ${GAMEDIR}/Songs
	keepdir ${GAMEDIR}/NoteSkins
	keepdir ${GAMEDIR}/Save

}

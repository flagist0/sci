# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/geant/geant-3.21.14-r3.ebuild,v 1.3 2012/10/24 19:42:46 ulm Exp $

EAPI=5

inherit eutils fortran-2 alternatives-2

DEB_PN=geant321
DEB_PV=${PV}.dfsg
DEB_PR=10
DEB_P=${DEB_PN}_${DEB_PV}

DESCRIPTION="CERN's detector description and simulation Tool"
HOMEPAGE="http://wwwasd.web.cern.ch/wwwasd/geant/"
SRC_URI="
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}.orig.tar.gz
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}-${DEB_PR}.diff.gz"

SLOT="3"
LICENSE="GPL-2 LGPL-2 BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	x11-libs/motif:0
	dev-lang/cfortran
	sci-physics/cernlib
	sci-physics/paw
	!sci-physics/geant-vmc:3"
DEPEND="${RDEPEND}
	virtual/latex-base
	x11-misc/imake
	x11-misc/makedepend"

S="${WORKDIR}/${DEB_PN}-${DEB_PV}.orig"

src_prepare() {
	cd "${WORKDIR}"
	sed -i -e 's:/tmp/dp.*/cern:cern:g' ${DEB_P}-${DEB_PR}.diff || die
	epatch ${DEB_P}-${DEB_PR}.diff
	cd "${S}"
	cp debian/add-ons/Makefile . || die
	export DEB_BUILD_OPTIONS="$(tc-getFC) nostrip nocheck"
	sed -i \
		-e "s:/usr/local:${EROOT}/usr:g" \
		Makefile || die "sed'ing the Makefile failed"
	einfo "Applying Debian patches"
	emake -j1 patch

	# since we depend on cfortran, do not use the one from cernlib
	rm src/include/cfortran/cfortran.h || die
}

src_compile() {
	# create local LaTeX cache directory
	VARTEXFONTS="${T}"/fonts
	emake -j1 cernlib-indep cernlib-arch
}

src_test_() {
	LD_LIBRARY_PATH="${S}"/shlib emake -j1 cernlib-test
}

src_install() {
	default
	cd debian
	dodoc changelog README.* deadpool.txt NEWS copyright
	newdoc add-ons/README README.add-ons
}

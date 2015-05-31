# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python{3_3,3_4} )

inherit distutils-r1

MY_PN="ipython_genutils"

DESCRIPTION="IPython vestigial utilities"
HOMEPAGE="https://github.com/ipython/ipython_genutils"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ipython/${MY_PN}.git git://github.com/ipython/${MY_PN}.git"
fi

if [ ${PV} == "0.1.0" ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ipython/${MY_PN}.git git://github.com/ipython/${MY_PN}.git"
	EGIT_COMMIT="0.1.0"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"
IUSE="test"

DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests --with-coverage --cover-package=ipython_genutils ipython_genutils || die
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Transcript-level quantification from RNA-seq reads using lightweight alignments"
HOMEPAGE="https://github.com/COMBINE-lab/salmon"
SRC_URI="https://github.com/COMBINE-lab/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

PATCHES=( "${FILESDIR}"/${P}-no-boost-static.patch )

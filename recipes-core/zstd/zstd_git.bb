SUMMARY = "Fast real-time compression algorithm."
HOMEPAGE = "https://github.com/facebook/zstd"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=c7f0b161edbe52f5f345a3d1311d0b32"

PV = "1.3.1"
SRC_URI = "git://github.com/facebook/zstd.git;protocol=https"
SRCREV = "aecf3b479c45affa9fd8ead068e9160253a8ec5c"

DEPENDS = "xz zlib"

S = "${WORKDIR}/git"

inherit pkgconfig

do_compile () {
    oe_runmake
}

do_install () {
    make DESTDIR=${D} PREFIX=${prefix} install
}

BBCLASSEXTEND = "native nativesdk"

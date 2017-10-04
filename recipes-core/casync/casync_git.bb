SUMMARY = "casync, a content-addressable data synchronizer"
HOMEPAGE = "https://github.com/systemd/casync"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c"

DEPENDS = "curl openssl zlib zstd acl"

PV = "2017.10"
SRC_URI = "git://github.com/systemd/casync.git;protocol=https \
           file://rpath.diff"
SRCREV = "6daefa8a008c3230495a76017eca546f6622bb1d"

S = "${WORKDIR}/git"

inherit meson pkgconfig

EXTRA_OEMESON += " \
    -Dselinux=false \
    -Dfuse=false \
    -Dman=false \
"

BBCLASSEXTEND = "native nativesdk"

SUMMARY = "casync, a content-addressable data synchronizer"
HOMEPAGE = "https://github.com/systemd/casync"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c"

DEPENDS = "curl openssl zlib zstd acl"

PV = "2017.11"
SRC_URI = "git://github.com/systemd/casync.git;protocol=https"
SRCREV = "dbac916ebff22081d891ad25da30a2216b9f3307"

S = "${WORKDIR}/git"

inherit casync_meson pkgconfig

EXTRA_OEMESON += " \
    -Dselinux=false \
    -Dfuse=false \
    -Dman=false \
"

BBCLASSEXTEND = "native nativesdk"

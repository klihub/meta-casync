SUMMARY = "casync, a content-addressable data synchronizer"
HOMEPAGE = "https://github.com/systemd/casync"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c"

DEPENDS = "curl openssl zlib zstd acl udev"

PV = "2017.11"
SRC_URI = "git://github.com/systemd/casync.git;protocol=https"
SRCREV = "4ad9bcb94bc83ff36cfc65515107ea06a88c2dfc"

S = "${WORKDIR}/git"

inherit meson pkgconfig

EXTRA_OEMESON += " \
    -Dselinux=false \
    -Dfuse=false \
    -Dman=false \
    -Dbashcompletiondir=no \
"

BBCLASSEXTEND = "native nativesdk"

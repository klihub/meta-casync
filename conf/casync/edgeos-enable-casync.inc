# Prevent shrinkwrap from removing anything we might need.
BIN_KEEP_append_pn-sdcard-image += " \
    ${IMAGE_ROOTFS}/usr/bin/casync* \
    ${IMAGE_ROOTFS}/usr/lib/casync/protocols/casync* \
    ${IMAGE_ROOTFS}/usr/lib/casync/udev/rules.d/*casync* \
    ${IMAGE_ROOTFS}/sbin/mkfs.ext4 \
    ${IMAGE_ROOTFS}/usr/share/swupdate/hooks.d/run-hooks \
    ${IMAGE_ROOTFS}/usr/share/swupdate/hooks.d/casync/* \
    ${IMAGE_ROOTFS}/usr/share/swupdate/hooks.d/swupd/* \
"

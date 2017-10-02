require conf/casync/casync-config.inc

do_casync_update () {
    if [ -f ${CASYNC_VERSION_FILE} ]; then
        version=$(cat ${CASYNC_VERSION_FILE})
    else
        version=0
    fi

    version=$(expr $version + 1)

    which casync
    ldd $(which casync)

    casync --verbose make \
        --store=${CASYNC_DEPLOY_DIR}/image.castr \
        ${CASYNC_DEPLOY_DIR}/$version.caidx \
        ${IMAGE_ROOTFS}

    echo $version > ${CASYNC_VERSION_FILE}
}

addtask casync_update after do_image_complete before do_build

do_casync_update[depends] = " \
    virtual/fakeroot-native:do_populate_sysroot \
    casync-native:do_populate_sysroot \
"

# We'll need casync in the image to pull in updates.
IMAGE_INSTALL_append = " casync"

# We need to have the kernel available in the rootfs itself, otherwise
# casync won't pull it in during an update. Once available, we can put
# it into its proper place by an update hook.
IMAGE_INSTALL_append = " kernel-image-bzimage"

# Class for generating casync-based image updates.
#
# This class updates a casync chunk store with the image rootfs and
# produces a corresponding index file. The index file and the chunk
# store can then later be used to create an identical replica of the
# image. The index files produced and directory (as opposed to block)
# indexes. They are enumerated in chronological order, starting from
# 1. The latest used version (= index) is stored in a filled called
# 'latest'. The latest index is also symlinked to latest.caidx.


require conf/casync/casync-config.inc

# read latest version in use
casync_read_latest () {
    _latest_file=${CASYNC_LATEST_FILE}

    mkdir -p ${CASYNC_DEPLOY_DIR}
    mkdir -p ${_latest_file%/*}

    if [ ! -f $_latest_file ]; then
        echo "${CASYNC_ZERO_VERSION}" > $_latest_file
    fi

    cat $_latest_file
}

# update latest version in use
casync_write_latest () {
    echo $1 > ${CASYNC_LATEST_FILE}
    rm -f ${CASYNC_LATEST_INDEX}
    ln -sf ${CASYNC_INDEX_DIR}/$1.caidx ${CASYNC_LATEST_INDEX}
}

# prepare rootfs for casync, write our version and update URL if given
casync_prepare_rootfs () {
    _version=$1
    _dir=${IMAGE_ROOTFS}${CASYNC_RUNTIME_DIR}
    _url=${CASYNC_UPDATE_URL}

    mkdir -p $_dir
    echo $_version > $_dir/version
    if [ -n "$_url" ]; then
        echo _url > $_dir/update-url
    fi
}

# populate casync chunk store with rootfs and generate version index file
casync_populate_store () {
    _idx=${CASYNC_INDEX_DIR}/$version.caidx
    _cmd="casync --verbose --without=selinux --without=acl \
         --store=${CASYNC_CHUNK_STORE} make $_idx ${IMAGE_ROOTFS}"

    PSEUDO="${FAKEROOTENV} ${FAKEROOTCMD}"
    echo "Populating casync chunk store with image version $version..."
    echo "Running casync command $_cmd"
    env $PSEUDO $_cmd
}

# task to generate a casync update for this rootfs
do_casync_rootfs () {
    version=$(expr $(casync_read_latest) + 1)

    casync_prepare_rootfs ${version}
    casync_populate_store
    casync_write_latest $version
}


addtask casync_rootfs after do_image_complete before do_build

do_casync_rootfs[depends] = " \
    virtual/fakeroot-native:do_populate_sysroot \
    virtual/kernel:do_populate_sysroot \
    casync-native:do_populate_sysroot \
"

# We need casync in the image to pull in updates. We also need to have
# the kernel available in the image itself, otherwise casync won't pull
# it in during an update and won't be able to put it into its proper
# final place.
IMAGE_INSTALL_append = " casync kernel-image-bzimage"

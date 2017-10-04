# Global configuration for casync-based image updates.

# casync base image name
CASYNC_IMAGE_PN = "${@ d.getVar('PN_BASE', True) or d.getVar('PN', True)}"

# per-image casync top directory
CASYNC_DEPLOY_DIR = "${DEPLOY_DIR}/casync/${MACHINE}/${CASYNC_IMAGE_PN}"

# directory for storing casync index files for image versions
CASYNC_INDEX_DIR = "${CASYNC_DEPLOY_DIR}"

# start versioning from this (+ 1)
CASYNC_ZERO_VERSION ?= "0"

# symlink to the index for the latest available version
CASYNC_LATEST_INDEX = "${CASYNC_DEPLOY_DIR}/latest.caidx"

# file for storing the latest available version number
CASYNC_LATEST_FILE = "${CASYNC_DEPLOY_DIR}/latest"

# casync chunk store
CASYNC_CHUNK_STORE = "${CASYNC_DEPLOY_DIR}/default.castr"

# on-device runtime casync directory
CASYNC_RUNTIME_DIR ?= "/var/lib/casync"

# casync update server URL, if any, to pre-configure image with
CASYNC_UPDATE_URL ?= ""

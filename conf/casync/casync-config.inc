# Casync base image name.
CASYNC_IMAGE_PN = "${@ d.getVar('PN_BASE', True) or d.getVar('PN', True)}"

# Where to put casync store and index files.
CASYNC_DEPLOY_DIR = "${DEPLOY_DIR}/casync/${MACHINE}/${CASYNC_IMAGE_PN}"

# File with latest stored version.
CASYNC_VERSION_FILE = "${CASYNC_DEPLOY_DIR}/latest"

# PREFERRED_PROVIDER_python3-modules-native = "nativesdk-python3"
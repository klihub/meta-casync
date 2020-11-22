BBCLASSEXTEND = "native nativesdk"

do_install_append_virtclass-native() {
  ln -sf ../bin/udevadm ${D}${sbindir}/udevadm
}

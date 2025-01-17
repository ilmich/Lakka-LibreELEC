# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mc"
PKG_VERSION="4.8.28"
PKG_SHA256="e994d9be9a7172e9ac4a4ad62107921f6aa312e668b056dfe5b8bcebbaf53803"
PKG_LICENSE="GPL"
PKG_SITE="http://www.midnight-commander.org"
PKG_URL="http://ftp.midnight-commander.org/mc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gettext:host glib libssh2 libtool:host ncurses pcre"
PKG_LONGDESC="Midnight Commander is a text based filemanager that emulates Norton Commander."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET=" \
  --datadir=/storage/.kodi/addons/virtual.system-tools/data \
  --libexecdir=/storage/.kodi/addons/virtual.system-tools/mclib \
  --with-homedir=/storage/.kodi/userdata/addon_data/virtual.system-tools \
  --sysconfdir=/storage/.kodi/addons/virtual.system-tools/etc \
  --with-screen=ncurses \
  --with-sysroot=${SYSROOT_PREFIX} \
  --disable-aspell \
  --without-diff-viewer \
  --disable-doxygen-doc \
  --disable-doxygen-dot \
  --disable-doxygen-html \
  --with-gnu-ld \
  --without-libiconv-prefix \
  --without-libintl-prefix \
  --with-internal-edit \
  --disable-mclib \
  --with-subshell \
  --enable-vfs-extfs \
  --enable-vfs-ftp \
  --enable-vfs-sftp \
  --enable-vfs-tar \
  --without-x"

pre_configure_target() {
  LDFLAGS+=" -lcrypto -lssl"
  CFLAGS+=' -DNCURSES_WIDECHAR=0'
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/storage/.kodi/addons/virtual.system-tools/data/locale
  rm -rf ${INSTALL}/storage/.kodi/addons/virtual.system-tools/data/mc/help/mc.hlp.*
  mv ${INSTALL}/usr/bin/mc ${INSTALL}/usr/bin/mc-bin
  rm -f ${INSTALL}/usr/bin/{mcedit,mcview}
  cp -p ${PKG_DIR}/wrapper/* ${INSTALL}/usr/bin
}

################################################################################
#
# bcachefs-tools
#
################################################################################

BCACHEFS_TOOLS_VERSION = 1.6.4
BCACHEFS_TOOLS_SOURCE = bcachefs-tools-vendored-$(BCACHEFS_TOOLS_VERSION).tar.zst
BCACHEFS_TOOLS_SITE = https://evilpiepirate.org/bcachefs-tools
BCACHEFS_TOOLS_LICENSE = GPL-2.0
BCACHEFS_TOOLS_LICENSE_FILES = COPYING
BCACHEFS_TOOLS_DEPENDENCIES = \
	host-rustc \
	host-clang \
	keyutils \
	libaio \
	libsodium \
	liburcu \
	lz4 \
	udev \
	util-linux \
	zlib \
	zstd

define BCACHEFS_TOOLS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define BCACHEFS_TOOLS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) \
		DESTDIR="$(TARGET_DIR)" PREFIX=/usr install
endef

$(eval $(generic-package))

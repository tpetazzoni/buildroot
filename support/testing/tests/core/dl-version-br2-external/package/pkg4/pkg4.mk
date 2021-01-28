PKG4_VERSION = 123
PKG4_DL_VERSION = baz-$(PKG4_VERSION)

$(eval $(generic-package))
$(eval $(host-generic-package))

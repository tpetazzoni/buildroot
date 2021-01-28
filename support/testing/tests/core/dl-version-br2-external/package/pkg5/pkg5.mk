PKG5_VERSION = 123
PKG5_DL_VERSION = baz-$(PKG5_VERSION)
HOST_PKG5_VERSION = 456
HOST_PKG5_DL_VERSION = bar-$(HOST_PKG5_VERSION)

$(eval $(generic-package))
$(eval $(host-generic-package))



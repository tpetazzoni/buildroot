################################################################################
#
# gcc-runtime
#
################################################################################

GCC_RUNTIME_VERSION = $(GCC_VERSION)
GCC_RUNTIME_SITE = $(GCC_SITE)
GCC_RUNTIME_SOURCE = $(GCC_SOURCE)
GCC_RUNTIME_DEPENDENCIES = host-gcc-final
GCC_RUNTIME_ADD_TOOLCHAIN_DEPENDENCY = NO

GCC_RUNTIME_LIBS = libgcc_s libatomic

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
GCC_RUNTIME_USR_LIBS += libstdc++
endif

ifeq ($(BR2_TOOLCHAIN_BUILDROOT_DLANG),y)
GCC_RUNTIME_USR_LIBS += libgdruntime libgphobos
endif

ifeq ($(BR2_TOOLCHAIN_BUILDROOT_FORTRAN),y)
GCC_RUNTIME_USR_LIBS += libgfortran
# fortran needs quadmath on x86 and x86_64
ifeq ($(BR2_TOOLCHAIN_HAS_LIBQUADMATH),y)
GCC_RUNTIME_USR_LIBS += libquadmath
endif
endif

ifeq ($(BR2_GCC_ENABLE_OPENMP),y)
GCC_RUNTIME_USR_LIBS += libgomp
endif

GCC_RUNTIME_USR_LIBS += $(call qstrip,$(BR2_TOOLCHAIN_EXTRA_LIBS))

define GCC_RUNTIME_INSTALL_STAGING_CMDS
	$(foreach lib,$(GCC_RUNTIME_LIBS), \
		cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib)* \
			$(STAGING_DIR)/lib/
	)
	$(foreach lib,$(GCC_RUNTIME_USR_LIBS), \
		cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib).a \
			$(STAGING_DIR)/usr/lib/
	)
	$(if $(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS), \
		$(foreach lib,$(GCC_RUNTIME_USR_LIBS), \
			cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib).so.* \
				$(STAGING_DIR)/usr/lib/
		)
	)
endef

define GCC_RUNTIME_INSTALL_TARGET_CMDS
	$(foreach lib,$(GCC_RUNTIME_LIBS), \
		cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib)* \
			$(TARGET_DIR)/lib/
	)
	$(if $(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS), \
		$(foreach lib,$(GCC_RUNTIME_USR_LIBS), \
			cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib).so.* \
				$(TARGET_DIR)/usr/lib/
		)
	)
endef

# coldfire is not working without removing these object files from libgcc.a
ifeq ($(BR2_m68k_cf),y)
define GCC_RUNTIME_M68K_LIBGCC_FIXUP
	find $(STAGING_DIR) -name libgcc.a -print | \
		while read t; do $(GNU_TARGET_NAME)-ar dv "$t" _ctors.o; done
endef
GCC_RUNTIME_POST_INSTALL_STAGING_HOOKS += GCC_RUNTIME_M68K_LIBGCC_FIXUP
endif

$(eval $(generic-package))

################################################################################
#
# jetson-firmware
#
################################################################################

JETSON_FIRMWARE_VERSION = 20200316 
JETSON_FIRMWARE_SITE = http://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
JETSON_FIRMWARE_SITE_METHOD = git

JETSON_FIRMWARE_DEPENDENCIES += linux

# Jetson TK1 XUSB controller 
ifeq ($(BR2_PACKAGE_JETSON_FIRMWARE_XUSB),y)
JETSON_FIRMWARE_FILES += nvidia/tegra124/xusb.bin 
JETSON_FIRMWARE_ALL_LICENSE_FILES += LICENCE.nvidia
endif

# Jetson TK1 realtek nic
ifeq ($(BR2_PACKAGE_JETSON_FIRMWARE_RTL816x),y)
JETSON_FIRMWARE_FILES += rtl_nic/rtl8168g-2.fw 
endif

# Jetson TK1 nouveau firmware
ifeq ($(BR2_PACKAGE_JETSON_FIRMWARE_NOUVEAU),y)
JETSON_FIRMWARE_FILES += \
  nvidia/tegra124/vic03_ucode.bin
JETSON_FIRMWARE_DIRS += nvidia/gk20a
JETSON_FIRMWARE_ALL_LICENSE_FILES += LICENSE.nvidia
endif

ifneq ($(JETSON_FIRMWARE_FILES),)
define JETSON_FIRMWARE_INSTALL_FILES
	cd $(@D) && \
		$(TAR) cf install.tar $(sort $(JETSON_FIRMWARE_FILES)) && \
		$(TAR) xf install.tar -C $(TARGET_DIR)/lib/firmware
endef
endif

ifneq ($(JETSON_FIRMWARE_DIRS),)
# We need to rm-rf the destination directory to avoid copying
# into it in itself, should we re-install the package.
define JETSON_FIRMWARE_INSTALL_DIRS
	$(foreach d,$(JETSON_FIRMWARE_DIRS), \
		rm -rf $(TARGET_DIR)/lib/firmware/$(d); \
		mkdir -p $(dir $(TARGET_DIR)/lib/firmware/$(d)); \
		cp -a $(@D)/$(d) $(TARGET_DIR)/lib/firmware/$(d)$(sep))
endef
endif

ifneq ($(JETSON_FIRMWARE_FILES)$(JETSON_FIRMWARE_DIRS),)

# Most firmware files are under a proprietary license, so no need to
# repeat it for every selections above. Those firmwares that have more
# lax licensing terms may still add them on a per-case basis.
JETSON_FIRMWARE_LICENSE += Proprietary

# This file contains some licensing information about all the firmware
# files found in the linux-firmware package, so we always add it, even
# for firmwares that have their own licensing terms.
JETSON_FIRMWARE_ALL_LICENSE_FILES += WHENCE

# Some license files may be listed more than once, so we have to remove
# duplicates
JETSON_FIRMWARE_LICENSE_FILES = $(sort $(JETSON_FIRMWARE_ALL_LICENSE_FILES))

endif

define JETSON_FIRMWARE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware
	$(JETSON_FIRMWARE_INSTALL_FILES)
	$(JETSON_FIRMWARE_INSTALL_DIRS)
endef

$(eval $(generic-package))

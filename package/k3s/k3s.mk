################################################################################
#
# k3s 
#
################################################################################

K3S_VERSION = v1.17.4+k3s1
K3S_SITE = https://github.com/rancher/k3s/releases/download/$(K3S_VERSION)/k3s-armhf 
K3S_EXTRA_DOWNLOADS = https://raw.githubusercontent.com/rancher/k3s/master/LICENSE
K3S_LICENSE = Apache-2.0 
K3S_ACTUAL_SOURCE_SITE = https://github.com/rancher/k3s.git

define K3S_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/k3s-armhf $(TARGET_DIR)/usr/bin
endef

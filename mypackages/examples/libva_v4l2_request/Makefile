include $(TOPDIR)/rules.mk
 
PKG_NAME:=libva_v4l2_request
PKG_VERSION:=2019.03
PKG_RELEASE:=1
 
SOURCE_DIR:=/home/richard/share/tmp/libva-v4l2-request-release-2019.03
 
include $(INCLUDE_DIR)/package.mk

define Package/libva_v4l2_request
  SECTION:=examples
  CATEGORY:=Examples
  TITLE:=libva-v4l2-request
endef

# Package description; a more verbose description on what our package does
define Package/libva_v4l2_request/description
  This libVA backend is designed to work with the Linux Video4Linux2 Request API that is used by a number of video codecs drivers, including the Video Engine found in most Allwinner SoCs.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cp -TR $(SOURCE_DIR) $(PKG_BUILD_DIR)
endef

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh)
	$(call Build/Configure/Default)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/.libs/*.so* $(1)/usr/lib
endef


define Build/InstallDev
	true
endef

define Package/libva_v4l2_request/install
	$(INSTALL_DIR) $(1)/usr/lib/
endef
 
$(eval $(call BuildPackage,libva_v4l2_request))

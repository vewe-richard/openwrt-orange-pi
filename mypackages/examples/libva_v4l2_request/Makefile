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
	cd $(PKG_BUILD_DIR) && autoreconf -vi
endef


#define Build/Configure
#endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef
 
#define Package/libva_v4l2_request/install
#endef
 
$(eval $(call BuildPackage,libva_v4l2_request))

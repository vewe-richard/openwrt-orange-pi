include $(TOPDIR)/rules.mk
 
PKG_NAME:=libdrm_c
PKG_VERSION:=2.4.100
PKG_RELEASE:=1
 
SOURCE_DIR:=/home/richard/share/tmp/drm-libdrm-2.4.100
 
include $(INCLUDE_DIR)/package.mk

define Package/libdrm_c
  SECTION:=examples
  CATEGORY:=Examples
  TITLE:=libdrm_c
endef

# Package description; a more verbose description on what our package does
define Package/libdrm_c/description
	libdrm customization
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cp -TR $(SOURCE_DIR) $(PKG_BUILD_DIR)
endef

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh)
	$(call Build/Configure/Default)
endef


define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		$(TARGET_CONFIGURE_OPTS) \
	       	CFLAGS="$(TARGET_CFLAGS) -I$(LINUX_DIR)/include" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef
 
#define Package/libdrm_c/install
#endef
 
$(eval $(call BuildPackage,libdrm_c))

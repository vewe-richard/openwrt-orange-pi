include $(TOPDIR)/rules.mk
 
PKG_NAME:=libdrm_sun4i
PKG_VERSION:=0.1
PKG_RELEASE:=1
 
SOURCE_DIR:=/home/richard/share/tmp/libdrm-sun4i
 
include $(INCLUDE_DIR)/package.mk

define Package/libdrm_sun4i
  SECTION:=examples
  CATEGORY:=Examples
  TITLE:=libdrm_sun4i
endef

# Package description; a more verbose description on what our package does
define Package/libdrm_sun4i/description
	Standard libdrm_sun4i
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
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef
 
#define Package/libdrm_sun4i/install
#endef
 
$(eval $(call BuildPackage,libdrm_sun4i))

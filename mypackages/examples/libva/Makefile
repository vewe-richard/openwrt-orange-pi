include $(TOPDIR)/rules.mk
 
PKG_NAME:=libva
PKG_VERSION:=2.14
PKG_RELEASE:=1
 
SOURCE_DIR:=/home/richard/share/tmp/libva-2.14-branch
 
include $(INCLUDE_DIR)/package.mk

define Package/libva
  SECTION:=examples
  CATEGORY:=Examples
  TITLE:=libva
endef

# Package description; a more verbose description on what our package does
define Package/libva/description
	Standard libva
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cp -TR $(SOURCE_DIR) $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && ./autogen.sh
endef


#define Build/Configure
#endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef
 
#define Package/libva/install
#endef
 
$(eval $(call BuildPackage,libva))

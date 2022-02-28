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
endef

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh)
	$(call Build/Configure/Default)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/glx/va_backend_glx.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_backend.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_backend_prot.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_backend_vpp.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/wayland/va_backend_wayland.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_compat.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_dec_av1.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_dec_hevc.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_dec_jpeg.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_dec_vp8.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_dec_vp9.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/x11/va_dri2.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_drmcommon.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/drm/va_drm.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_egl.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_enc_av1.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_enc_h264.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_enc_hevc.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_enc_jpeg.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_enc_mpeg2.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_enc_vp8.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_enc_vp9.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_fei.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_fei_h264.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_fei_hevc.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/glx/va_glx.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_prot.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_str.h $(1)/usr/include/va/    
	$(CP) $(PKG_BUILD_DIR)/va/va_tpi.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_version.h $(1)/usr/include/va/ 
	$(CP) $(PKG_BUILD_DIR)/va/va_vpp.h $(1)/usr/include/va/     
	$(CP) $(PKG_BUILD_DIR)/va/wayland/va_wayland.h $(1)/usr/include/va/
	$(CP) $(PKG_BUILD_DIR)/va/va_x11.h $(1)/usr/include/va/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/pkgconfig/libva-drm.pc $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/pkgconfig/libva-glx.pc $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/pkgconfig/libva.pc $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/pkgconfig/libva-wayland.pc $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/pkgconfig/libva-x11.pc $(1)/usr/lib/pkgconfig

	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/va/.libs/lib*.so* $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/va/.libs/lib*.la* $(1)/usr/lib
endef

define Package/libva/install
	true
endef
 
$(eval $(call BuildPackage,libva))

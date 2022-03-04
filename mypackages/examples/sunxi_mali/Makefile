include $(TOPDIR)/rules.mk
 
PKG_NAME:=sunxi_mali
PKG_VERSION:=0.1
PKG_RELEASE:=1
 
SOURCE_DIR:=/home/richard/share/tmp/sunxi-mali
 
include $(INCLUDE_DIR)/package.mk

define Package/sunxi_mali
  SECTION:=examples
  CATEGORY:=Examples
  TITLE:=sunxi_mali
endef

# Package description; a more verbose description on what our package does
define Package/sunxi_mali/description
	Standard sunxi_mali
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cp -TR $(SOURCE_DIR) $(PKG_BUILD_DIR)
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/lib/mali/r3p1/armhf/framebuffer/libMali.so $(1)/usr/lib
	$(LN) -r $(1)/usr/lib/libMali.so $(1)/usr/lib/libEGL.so.1.4
	$(LN) -r $(1)/usr/lib/libEGL.so.1.4 $(1)/usr/lib/libEGL.so.1
	$(LN) -r $(1)/usr/lib/libEGL.so.1 $(1)/usr/lib/libEGL.so
	$(LN) -r $(1)/usr/lib/libMali.so $(1)/usr/lib/libGLESv1_CM.so.1.1
	$(LN) -r $(1)/usr/lib/libGLESv1_CM.so.1.1 $(1)/usr/lib/libGLESv1_CM.so.1
	$(LN) -r $(1)/usr/lib/libGLESv1_CM.so.1 $(1)/usr/lib/libGLESv1_CM.so
	$(LN) -r $(1)/usr/lib/libMali.so $(1)/usr/lib/libGLESv2.so.2.0
	$(LN) -r $(1)/usr/lib/libGLESv2.so.2.0 $(1)/usr/lib/libGLESv2.so.2
	$(LN) -r $(1)/usr/lib/libGLESv2.so.2 $(1)/usr/lib/libGLESv2.so

	
	$(INSTALL_DIR) $(1)/usr/include/EGL
	$(CP) $(PKG_BUILD_DIR)/include/EGL/eglplatform.h $(1)/usr/include/EGL
	$(CP) $(PKG_BUILD_DIR)/include/EGL/egl.h $(1)/usr/include/EGL
	$(CP) $(PKG_BUILD_DIR)/include/EGL/eglext.h $(1)/usr/include/EGL

	$(INSTALL_DIR) $(1)/usr/include/GLES
	$(CP) $(PKG_BUILD_DIR)/include/GLES/gl.h $(1)/usr/include/GLES
	$(CP) $(PKG_BUILD_DIR)/include/GLES/glext.h $(1)/usr/include/GLES
	$(CP) $(PKG_BUILD_DIR)/include/GLES/glplatform.h $(1)/usr/include/GLES

	$(INSTALL_DIR) $(1)/usr/include/GLES2
	$(CP) $(PKG_BUILD_DIR)/include/GLES2/gl2.h $(1)/usr/include/GLES2
	$(CP) $(PKG_BUILD_DIR)/include/GLES2/gl2ext.h $(1)/usr/include/GLES2
	$(CP) $(PKG_BUILD_DIR)/include/GLES2/gl2platform.h $(1)/usr/include/GLES2

	$(INSTALL_DIR) $(1)/usr/include/KHR
	$(CP) $(PKG_BUILD_DIR)/include/KHR/khrplatform.h $(1)/usr/include/KHR


endef

define Package/sunxi_mali/install
	true
endef
 
$(eval $(call BuildPackage,sunxi_mali))

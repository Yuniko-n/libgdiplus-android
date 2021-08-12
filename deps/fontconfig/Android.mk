LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE     := fontconfig

LOCAL_CFLAGS := -DHAVE_CONFIG_H

# Additional font directories
LOCAL_CFLAGS += -DFC_CACHEDIR=\"/sdcard/fontconfig/cache\"
LOCAL_CFLAGS += -DFC_TEMPLATEDIR=\"/sdcard/fontconfig/conf.avail\"
LOCAL_CFLAGS += -DFONTCONFIG_PATH=\"/sdcard/fontconfig/etc/fonts\"
LOCAL_CFLAGS += -DFC_ADD_FONTS=\"/sdcard/fontconfig/fonts\"
# System font directory
LOCAL_CFLAGS += -DFC_DEFAULT_FONTS=\"/system/fonts\"
ifeq ($(USE_ICONV),true)
    LOCAL_CFLAGS += -DUSE_ICONV=1
    LOCAL_STATIC_LIBRARIES += libiconv
endif

LOCAL_STATIC_LIBRARIES += freetype libexpat libuuid

include $(LOCAL_PATH)/src/Sources.mk

LOCAL_SRC_FILES  := $(addprefix src/, $(filter %.c, $(libfontconfig_la_SOURCES)))

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/android \
    $(LOCAL_PATH)/src \
    $(LOCAL_PATH)/../freetype/include \
    $(LOCAL_PATH)/../libexpat \
    $(LOCAL_PATH)/../libuuid/include \
    $(LOCAL_PATH)/../libiconv

include $(BUILD_STATIC_LIBRARY)

$(call import-module,deps/freetype)
$(call import-module,deps/libexpat)
$(call import-module,deps/libuuid)
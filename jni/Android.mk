LOCAL_PATH := $(call my-dir)/..

#################################
USE_LIBEXIF ?= false
USE_LIBGIF ?= false
USE_LIBTIFF ?= false

USE_ICONV ?= false
USE_ZLIB ?= true

######### [libgdiplus] ##########
include $(CLEAR_VARS)
LOCAL_MODULE := libgdiplus

LOCAL_CFLAGS           += -DHAVE_CONFIG_H

LOCAL_STATIC_LIBRARIES += cairo
LOCAL_STATIC_LIBRARIES += eglib
LOCAL_STATIC_LIBRARIES += libjpeg

ifeq ($(USE_LIBEXIF),true)
    LOCAL_CFLAGS           += -DHAVE_LIBEXIF=1
    LOCAL_STATIC_LIBRARIES += libexif
endif
ifeq ($(USE_LIBGIF),true)
    LOCAL_CFLAGS           += -DHAVE_LIBGIF=1
    LOCAL_STATIC_LIBRARIES += libgif
endif
ifeq ($(USE_LIBTIFF),true)
    LOCAL_CFLAGS           += -DHAVE_LIBTIFF=1
    LOCAL_STATIC_LIBRARIES += libtiff
endif

LOCAL_C_INCLUDES += $(LOCAL_PATH)/jni \
                    $(LOCAL_PATH)/src \
                    $(LOCAL_PATH)/deps/cairo \
                    $(LOCAL_PATH)/deps/cairo/android \
                    $(LOCAL_PATH)/deps/cairo/cairo \
                    $(LOCAL_PATH)/deps/eglib \
                    $(LOCAL_PATH)/deps/fontconfig \
                    $(LOCAL_PATH)/deps/freetype/include \
                    $(LOCAL_PATH)/deps/libexif \
                    $(LOCAL_PATH)/deps/libgif \
                    $(LOCAL_PATH)/deps/libjpeg \
                    $(LOCAL_PATH)/deps/libpng \
                    $(LOCAL_PATH)/deps/libtiff \

LOCAL_SRC_FILES := \
                   src/adjustablearrowcap.c \
                   src/bitmap.c \
                   src/bmpcodec.c \
                   src/brush.c \
                   src/carbon-private.c \
                   src/customlinecap.c \
                   src/dstream.c \
                   src/emfcodec.c \
                   src/emfplus.c \
                   src/font.c \
                   src/gdi32.c \
                   src/general.c \
                   src/gifcodec.c \
                   src/graphics-cairo.c \
                   src/graphics-metafile.c \
                   src/graphics-path.c \
                   src/graphics-pathiterator.c \
                   src/graphics.c \
                   src/hatchbrush.c \
                   src/icocodec.c \
                   src/image.c \
                   src/imageattributes.c \
                   src/jpegcodec.c \
                   src/lineargradientbrush.c \
                   src/matrix.c \
                   src/metafile.c \
                   src/pathgradientbrush.c \
                   src/pen.c \
                   src/pngcodec.c \
                   src/print.c \
                   src/region-bitmap.c \
                   src/region-path-tree.c \
                   src/region.c \
                   src/solidbrush.c \
                   src/stringformat.c \
                   src/text-cairo.c \
                   src/text-metafile.c \
                   src/text-pango.c \
                   src/text.c \
                   src/texturebrush.c \
                   src/tiffcodec.c \
                   src/wmfcodec.c

include $(BUILD_SHARED_LIBRARY)
$(call import-add-path,$(LOCAL_PATH))
$(call import-module,deps/cairo)
$(call import-module,deps/eglib)
$(call import-module,deps/libjpeg)

ifeq ($(USE_LIBEXIF),true)
    $(call import-module,deps/libexif)
endif
ifeq ($(USE_LIBGIF),true)
    $(call import-module,deps/libgif)
endif
ifeq ($(USE_LIBTIFF),true)
    $(call import-module,deps/libtiff)
endif
ifeq ($(USE_ICONV),true)
    $(call import-module,deps/libiconv)
endif
ifeq ($(USE_ZLIB),true)
    $(call import-module,deps/zlib)
endif
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CFLAGS += \
    -Wno-shift-op-parentheses \
    -Wno-string-plus-int \
    -Wno-dangling-else \
    -Wno-bitwise-op-parentheses

LOCAL_MODULE     := libiconv

LOCAL_SRC_FILES  := iconv.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)

include $(BUILD_STATIC_LIBRARY)
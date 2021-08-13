LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := pixman

LOCAL_SRC_FILES += \
    pixman-access-accessors.c \
    pixman-access.c \
    pixman-arm.c \
    pixman-bits-image.c \
    pixman-combine-float.c \
    pixman-combine32.c \
    pixman-conical-gradient.c \
    pixman-edge-accessors.c \
    pixman-edge.c \
    pixman-fast-path.c \
    pixman-filter.c \
    pixman-general.c \
    pixman-glyph.c \
    pixman-gradient-walker.c \
    pixman-image.c \
    pixman-implementation.c \
    pixman-linear-gradient.c \
    pixman-matrix.c \
    pixman-mips.c \
    pixman-noop.c \
    pixman-ppc.c \
    pixman-radial-gradient.c \
    pixman-region16.c \
    pixman-region32.c \
    pixman-solid-fill.c \
    pixman-timer.c \
    pixman-trap.c \
    pixman-utils.c \
    pixman-x86.c \
    pixman.c

LOCAL_CFLAGS := -DHAVE_PTHREADS -DPACKAGE=\"pixman-1\"

ifeq ($(TARGET_ARCH_ABI),x86)
LOCAL_CFLAGS += -DUSE_SSE2
LOCAL_SRC_FILES  += pixman-sse2.c
endif

ifeq ($(TARGET_ARCH_ABI),x86_64)
LOCAL_CFLAGS += -DUSE_SSE2
LOCAL_SRC_FILES  += pixman-sse2.c
endif

include $(BUILD_STATIC_LIBRARY)

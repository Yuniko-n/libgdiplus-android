LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := eglib

ifeq ($(USE_ICONV),true)
    LOCAL_CFLAGS += -DHAVE_ICONV_H=1 -DHAVE_LIBICONV=1
    LOCAL_C_INCLUDES += $(LOCAL_PATH)/../libiconv
    LOCAL_STATIC_LIBRARIES += libiconv
endif

LOCAL_C_INCLUDES += $(LOCAL_PATH)

LOCAL_SRC_FILES := \
    garray.c \
    gbytearray.c \
    gdate-unix.c \
    gdir-unix.c \
    gerror.c \
    gfile-posix.c \
    gfile-unix.c \
    gfile.c \
    ghashtable.c \
    giconv.c \
    glist.c \
    gmarkup.c \
    gmem.c \
    gmisc-unix.c \
    gmodule-aix.c \
    gmodule-unix.c \
    gmutex.c \
    goutput.c \
    gpath.c \
    gpattern.c \
    gptrarray.c \
    gqsort.c \
    gqueue.c \
    gshell.c \
    gslist.c \
    gspawn.c \
    gstr.c \
    gstring.c \
    gtimer-unix.c \
    gunicode.c \
    gutf8.c

include $(BUILD_STATIC_LIBRARY)

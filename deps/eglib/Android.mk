LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := eglib


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

LOCAL_C_INCLUDES += $(LOCAL_PATH)/../libiconv/include \

#LOCAL_CFLAGS     += -DHAVE_CONFIG_H

LOCAL_EXPORT_LDLIBS := -lz
LOCAL_STATIC_LIBRARIES += libiconv

include $(BUILD_STATIC_LIBRARY)

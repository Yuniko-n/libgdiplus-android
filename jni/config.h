/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Define if building universal (internal helper macro) */
/* #undef AC_APPLE_UNIVERSAL_BUILD */

/* AIX or PASE */
/* #undef AIX */

/* OpenBSD */
/* #undef BSDOS */

/* Win32 */
/* #undef CYGWIN */

/* Define to 1 if you have the <byteswap.h> header file. */
#define HAVE_BYTESWAP_H 1

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Define to 1 if you have the `FcFini' function. */
#define HAVE_FCFINI 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define if libexif is available. */
#define HAVE_LIBEXIF 1

/* Define to 1 if you have the `fontconfig' library (-lfontconfig). */
#define HAVE_LIBFONTCONFIG 1

/* Define if gif support is available */
#define HAVE_LIBGIF 1

/* Define if jpeg support is available */
#define HAVE_LIBJPEG 1

/* Define if png support is available. Always defined. */
#define HAVE_LIBPNG 1

/* Define to 1 if you have the `pthread' library (-lpthread). */
#define HAVE_LIBPTHREAD 1

/* Define if tiff support is available */
#define HAVE_LIBTIFF 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* sigsetjmp is available */
#define HAVE_SIGSETJMP 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Support for the visibility ("hidden") attribute */
#define HAVE_VISIBILITY_HIDDEN 1

/* Define if x11 is available. */
//#define HAVE_X11 1

/* Linux */
#define LINUX 1

/* Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

/* OS X */
/* #undef OSX */

/* Unknown */
/* #undef OTHEROS */

/* Name of package */
#define PACKAGE "libgdiplus"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "https://github.com/mono/mono/issues/new"

/* Define to the full name of this package. */
#define PACKAGE_NAME "libgdiplus"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "libgdiplus 6.0.5"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "libgdiplus"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "6.0.5"

/* Solaris */
/* #undef SOLARIS */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Use Pango to measure and draw text */
/* #undef USE_PANGO_RENDERING */

/* Version number of package */
#define VERSION "6.0.5"

/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif

/* For libc reentrancy */
/* #undef _REENTRANT */

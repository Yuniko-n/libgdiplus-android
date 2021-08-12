LIBCAIRO_SRC = \
	       cairo/cairo-analysis-surface.c            \
	       cairo/cairo-arc.c                         \
	       cairo/cairo-array.c                       \
	       cairo/cairo-atomic.c                      \
	       cairo/cairo-base64-stream.c               \
	       cairo/cairo-base85-stream.c               \
	       cairo/cairo-bentley-ottmann-rectangular.c \
	       cairo/cairo-bentley-ottmann-rectilinear.c \
	       cairo/cairo-bentley-ottmann.c             \
	       cairo/cairo-botor-scan-converter.c        \
	       cairo/cairo-boxes-intersect.c             \
	       cairo/cairo-boxes.c                       \
	       cairo/cairo.c                             \
	       cairo/cairo-cache.c                       \
	       cairo/cairo-cff-subset.c                  \
	       cairo/cairo-clip-boxes.c                  \
	       cairo/cairo-clip-polygon.c                \
	       cairo/cairo-clip-region.c                 \
	       cairo/cairo-clip-surface.c                \
	       cairo/cairo-clip-tor-scan-converter.c     \
	       cairo/cairo-clip.c                        \
	       cairo/cairo-color.c                       \
	       cairo/cairo-composite-rectangles.c        \
	       cairo/cairo-compositor.c                  \
	       cairo/cairo-contour.c                     \
	       cairo/cairo-damage.c                      \
	       cairo/cairo-debug.c                       \
	       cairo/cairo-default-context.c             \
	       cairo/cairo-deflate-stream.c              \
	       cairo/cairo-device.c                      \
	       cairo/cairo-error.c                       \
	       cairo/cairo-fallback-compositor.c         \
	       cairo/cairo-fixed.c                       \
	       cairo/cairo-font-face-twin-data.c         \
	       cairo/cairo-font-face-twin.c              \
	       cairo/cairo-font-face.c                   \
	       cairo/cairo-font-options.c                \
	       cairo/cairo-freed-pool.c                  \
	       cairo/cairo-freelist.c                    \
           cairo/cairo-ft-font.c                     \
	       cairo/cairo-gstate.c                      \
	       cairo/cairo-hash.c                        \
	       cairo/cairo-hull.c                        \
	       cairo/cairo-image-compositor.c            \
	       cairo/cairo-image-info.c                  \
	       cairo/cairo-image-source.c                \
	       cairo/cairo-image-surface.c               \
	       cairo/cairo-line.c                        \
	       cairo/cairo-lzw.c                         \
	       cairo/cairo-mask-compositor.c             \
	       cairo/cairo-matrix.c                      \
	       cairo/cairo-mempool.c                     \
	       cairo/cairo-mesh-pattern-rasterizer.c     \
	       cairo/cairo-misc.c                        \
	       cairo/cairo-mono-scan-converter.c         \
	       cairo/cairo-mutex.c                       \
	       cairo/cairo-no-compositor.c               \
	       cairo/cairo-observer.c                    \
	       cairo/cairo-output-stream.c               \
	       cairo/cairo-paginated-surface.c           \
	       cairo/cairo-path-bounds.c                 \
	       cairo/cairo-path-fill.c                   \
	       cairo/cairo-path-fixed.c                  \
	       cairo/cairo-path-in-fill.c                \
	       cairo/cairo-path-stroke-boxes.c           \
	       cairo/cairo-path-stroke-polygon.c         \
	       cairo/cairo-path-stroke-traps.c           \
	       cairo/cairo-path-stroke-tristrip.c        \
	       cairo/cairo-path-stroke.c                 \
	       cairo/cairo-path.c                        \
	       cairo/cairo-pattern.c                     \
	       cairo/cairo-pdf-interchange.c             \
	       cairo/cairo-pdf-operators.c               \
	       cairo/cairo-pdf-shading.c                 \
	       cairo/cairo-pdf-surface.c                 \
	       cairo/cairo-pen.c                         \
	       cairo/cairo-png.c                         \
	       cairo/cairo-polygon-intersect.c           \
	       cairo/cairo-polygon-reduce.c              \
	       cairo/cairo-polygon.c                     \
	       cairo/cairo-ps-surface.c                  \
	       cairo/cairo-raster-source-pattern.c       \
	       cairo/cairo-recording-surface.c           \
	       cairo/cairo-rectangle.c                   \
	       cairo/cairo-rectangular-scan-converter.c  \
	       cairo/cairo-region.c                      \
	       cairo/cairo-rtree.c                       \
	       cairo/cairo-scaled-font-subsets.c         \
	       cairo/cairo-scaled-font.c                 \
	       cairo/cairo-script-surface.c              \
	       cairo/cairo-shape-mask-compositor.c       \
	       cairo/cairo-slope.c                       \
	       cairo/cairo-spans-compositor.c            \
	       cairo/cairo-spans.c                       \
	       cairo/cairo-spline.c                      \
	       cairo/cairo-stroke-dash.c                 \
	       cairo/cairo-stroke-style.c                \
	       cairo/cairo-surface-clipper.c             \
	       cairo/cairo-surface-fallback.c            \
	       cairo/cairo-surface-observer.c            \
	       cairo/cairo-surface-offset.c              \
	       cairo/cairo-surface-snapshot.c            \
	       cairo/cairo-surface-subsurface.c          \
	       cairo/cairo-surface-wrapper.c             \
	       cairo/cairo-surface.c                     \
	       cairo/cairo-svg-surface.c                 \
	       cairo/cairo-tag-attributes.c              \
	       cairo/cairo-tag-stack.c                   \
	       cairo/cairo-tee-surface.c                 \
	       cairo/cairo-time.c                        \
	       cairo/cairo-tor-scan-converter.c          \
	       cairo/cairo-tor22-scan-converter.c        \
	       cairo/cairo-toy-font-face.c               \
	       cairo/cairo-traps-compositor.c            \
	       cairo/cairo-traps.c                       \
	       cairo/cairo-tristrip.c                    \
	       cairo/cairo-truetype-subset.c             \
	       cairo/cairo-type1-fallback.c              \
	       cairo/cairo-type1-glyph-names.c           \
	       cairo/cairo-type1-subset.c                \
	       cairo/cairo-type3-glyph-surface.c         \
	       cairo/cairo-unicode.c                     \
	       cairo/cairo-user-font.c                   \
	       cairo/cairo-version.c                     \
	       cairo/cairo-wideint.c                     \

LIBCAIRO_CFLAGS:= -DCAIRO_HAS_PTHREAD=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UINT64_T=1 -DHAVE_UNISTD_H=1

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := cairo
LOCAL_CFLAGS    := $(LIBCAIRO_CFLAGS) -w
LOCAL_SRC_FILES := $(LIBCAIRO_SRC)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/android \
					$(LOCAL_PATH)/../fontconfig \
					$(LOCAL_PATH)/../freetype/include \
					$(LOCAL_PATH)/../pixman \
					$(LOCAL_PATH)/../libpng \

LOCAL_STATIC_LIBRARIES := fontconfig libpng pixman

include $(BUILD_STATIC_LIBRARY)
$(call import-module,deps/fontconfig)
$(call import-module,deps/libpng)
$(call import-module,deps/pixman)
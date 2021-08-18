# libgdiplus-android
适用于Android的 [libgdiplus](https://github.com/mono/libgdiplus)

主要用于解决 **Unity** 安卓平台无法使用 `System.Drawing.dll` 插件的问题

## 下载NDK
https://developer.android.com/ndk/downloads/older_releases.html

## 编译
```
ndk-build
```

如果编译失败，请尝试：ndk-r23-beta2、ndk-r22b、ndk-r21e、ndk-r15b、ndk-r10e

## 使用到的库
|    名称    |   版本   |
| ---------- | -------- |
| cairo      |  1.17.4  |
| eglib      |  eglib   |
| fontconfig |  2.13.1  |
| freetype   |  2.10.1  |
| libexif    |  0.6.22  |
| libexpat   |  2.3.0   |
| libgif     |  5.2.1   |
| libiconv   |  mini    |
| libjpeg    |  9d      |
| libpng     |  1.6.37  |
| libtiff    |  4.3.0   |
| libuuid    |  1.0.3   |
| pixman     |  0.38.4  |
| zlib       |  1.2.11  |

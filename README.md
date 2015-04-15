android_device_lenovo_kai
=========================

Lenovo Ideatab A2109A (kai)

This is aosp for Lenovo Ideatab A2109A (kai)

Special thanks to Aospplus developers, who already did most of what I'm trying to accomplish:
  Lloir
  Tom Briden

Special thanks for JB-4.2 to the tf700t developers for Cyanogenmod:
  dasunsrule32
  xplodwild
  nycbjr

Thanks to the A2109A pioneers:
  superhansi
  gmarkall
  kahlo007

|Category |Feature |Working |Not working |Unknown |
|---------|--------|--------|------------|--------|
|EGL | |X | | |
|WLAN | | | | |
|  |Client mode |X | | |
|  |P2P | |X | |
|Bluetooth | | | |
|  |Send files |X | | |
|  |Receive files | |X | |
|  |Headset |X | | |
|Camera | | | | |
|  |Preview |X | | |
|  |Regular pictures |X | | |
|  |Panorama pictures |X | | |
|  |SD Video recording |X | | |
|  |HD Video recording |X | | |
|Media | | | | |
|  |Playing videos |X | | |
|  |Playing sound |X | | |
|  |Microphone |X | | |
|GPS | |X | | |
|HDMI out | | | |X |
|USB-OTG | | | |X |

Some basic hardware info
-Bluetooth: BCM4330
-GPS: BCM47511
-WiFi: BCMDHD
-Audio: tegra-aic326x
-Touchscreen: ft5x0x_ts
-Accelerometer: lis3dh
-Ambient light sensor: Solteam JSA1127	
-Back camera: s5k5cag
-Front camera: mt9m114


GPS errors with grouper HAL:
D/libgps  (  385): proxy_gps_set_position_mode()
D/libgps  (  385): gps_set_position_mode: Waiting for IPC connection...
D/libgps  (  385): gps_set_position_mode: Waiting for IPC connection - timeout
E/libgps  (  385): LIBGPS: Cannot communicate (write) with a GPSD
E/libgps  (  385): IPC Communication Error, /tmp/11862727/customers/Asustek/Tabletandroid/../../../proprietary/deliverables/android/gps_interface/../gps_interface/gpsi_client/GpsiClient.cpp:915 gps_set_position_mode
E/GpsLocationProvider(  385): set_position_mode failed in startNavigating()

Working GPS combo's:
tf700 gpsconfig.xml gps.tegra.so and kai glgps

Some notes on other repos. ParanoidAndroid uses the following from tf700 (excluding gsm / apps):
device/common
frameworks/av
frameworks/native
hardware/libhardware
hardware/libhardware_legacy


Camera errors:
Vendor skia + jpeg:
E/HAL     (  282): load: module=/system/lib/hw/camera.tegra3.so
E/HAL     (  282): Cannot load library: soinfo_link_image(linker.cpp:1635): could not load library "libandroid_runtime.so" needed by "camera.tegra3.so"; caused by soinfo_relocate(linker.cpp:975): cannot locate symbol 
"_ZN10SkLanguage7getInfoEPKc" referenced by "libandroid_runtime.so"...
E/CameraService(  282): Could not load camera HAL module

Vendor jpeg, aosp skia
E/NvOmxCamera(  111): createCameraObjects: graph creation failed! [0x80001005]
E/NvOmxCamera(  111): NvOmxCamera::createObjects :::: FAIL ::::::::::::::::: [0x80001005]
E/gralloc (  108): failed to load symbol nvcap_video_create (Symbol not found: )

Vendor jpeg, aosp skia, compiled against old libjpeg-turbo
E/gralloc (  107): creating nvcap video capture service
E/NvOmxCamera(  110): createCameraObjects: graph creation failed! [0x80001005]
E/NvOmxCamera(  110): NvOmxCamera::createObjects :::: FAIL ::::::::::::::::: [0x80001005]
E/gralloc (  107): failed to load symbol nvcap_video_create (Symbol not found: )

Vendor skia + jpeg, compiled against old libjpeg-turbo
I/CameraService(  111): CameraService started (pid=111)
E/HAL     (  111): load: module=/system/lib/hw/camera.tegra3.so
E/HAL     (  111): Cannot load library: soinfo_link_image(linker.cpp:1635): could not load library "libandroid_runtime.so" needed by "camera.tegra3.so"; caused by soinfo_relocate(linker.cpp:975): cannot locate symbol 
"_ZN10SkLanguage7getInfoEPKc" referenced by "libandroid_runtime.so"...
E/CameraService(  111): Could not load camera HAL module

Some Build errors:
device/lenovo/kai/config/nvaudio_conf.xml:19: validity error : Redefinition of element alsa_device
  <!ELEMENT alsa_device EMPTY>
                              ^
device/lenovo/kai/config/nvaudio_conf.xml:24: validity error : Redefinition of element alsa_device
  <!ELEMENT alsa_device EMPTY>
                              ^
device/lenovo/kai/config/nvaudio_conf.xml:35: validity error : Redefinition of element pcm_config
  <!ELEMENT pcm_config EMPTY>
                             ^
device/lenovo/kai/config/nvaudio_conf.xml:36: validity error : Redefinition of element device
  <!ELEMENT device EMPTY>
                         ^
device/lenovo/kai/config/nvaudio_conf.xml:38: validity error : Redefinition of element device
  <!ELEMENT device EMPTY>
                         ^
device/lenovo/kai/config/nvaudio_conf.xml:39: validity error : Redefinition of element path
  <!ELEMENT path EMPTY>
                       ^
device/lenovo/kai/config/nvaudio_conf.xml:41: validity error : Redefinition of element path
  <!ELEMENT path EMPTY>
                       ^
device/lenovo/kai/config/nvaudio_conf.xml:45: validity error : Redefinition of element param
  <!ELEMENT param EMPTY>
                        ^
device/lenovo/kai/config/nvaudio_conf.xml:49: validity error : Redefinition of element ctl
  <!ELEMENT ctl EMPTY>

Bisect log for frameworks/native

git bisect start
# good: [529cb9ed9c5d62d5b270cdd650380ae116382143] merge in jb-mr1.1-release history after reset to jb-mr1.1-dev
git bisect good 529cb9ed9c5d62d5b270cdd650380ae116382143
# bad: [1b385b455c9bedcabcf8e21f3cf958b09cccc6a4] Configure dalvik heap parameters for low memory devices
git bisect bad 1b385b455c9bedcabcf8e21f3cf958b09cccc6a4
# bad: [73f454cc0790e782ffdd361768482a2b38570084] FM Radio: Add support for FM Radio in Android
git bisect bad 73f454cc0790e782ffdd361768482a2b38570084
# good: [a0a706b8258863757cf2e3664c8fddaa794a0514] DisplayDevice: Backwards compatibility with old EGL
git bisect good a0a706b8258863757cf2e3664c8fddaa794a0514
# good: [18aefe944472f2def2ace61a46f5002773413b43] dumpstate: Squash fixes from CM 10.0
git bisect good 18aefe944472f2def2ace61a46f5002773413b43
# bad: [77ddb6525b8a9323fcfff54fcbcb62820a8d540d] ui/sf: Add support for exynos HDMI
git bisect bad 77ddb6525b8a9323fcfff54fcbcb62820a8d540d
# bad: [778777acb3567c51681bb29c3ca081694ae70969] Merge branch 'jb-mr1-release' of https://android.googlesource.com/platform/frameworks/native into aosp
git bisect bad 778777acb3567c51681bb29c3ca081694ae70969
# bad: [d262585108ecede466678a84ddb3cb190935b12e] Add setOrientation back
git bisect bad d262585108ecede466678a84ddb3cb190935b12e
# first bad commit: [d262585108ecede466678a84ddb3cb190935b12e] Add setOrientation back

git bisect start
# good: [529cb9ed9c5d62d5b270cdd650380ae116382143] merge in jb-mr1.1-release history after reset to jb-mr1.1-dev
git bisect good 529cb9ed9c5d62d5b270cdd650380ae116382143
# bad: [18aefe944472f2def2ace61a46f5002773413b43] dumpstate: Squash fixes from CM 10.0
git bisect bad 18aefe944472f2def2ace61a46f5002773413b43
# good: [02b95105754b1859a97e234b79f41489a4677c20] fix transitions from hwc to GLES composition
git bisect good 02b95105754b1859a97e234b79f41489a4677c20
# bad: [7db063a544bb1acd902f7c752f9e769c5bc0caf9] ui: exynos4: getphys is common
git bisect bad 7db063a544bb1acd902f7c752f9e769c5bc0caf9
# good: [2b77c3e473c4347e34d2fae9dcf32366fd629b33] exynos4: getphys implementation on buffermanager for samsung omx
git bisect good 2b77c3e473c4347e34d2fae9dcf32366fd629b33
# bad: [e657227f88844f31da7f9a11c783c84bdbbc80bd] libgui: Add ICS/MR0-compatible client::createSurface constructors
git bisect bad e657227f88844f31da7f9a11c783c84bdbbc80bd
# good: [c0f52aabe2ab8c859c4f3a790f6c8b0ec40107ba] Revert "Revert "Compatibility work around for bad graphics driver dependency.""
git bisect good c0f52aabe2ab8c859c4f3a790f6c8b0ec40107ba
# first bad commit: [e657227f88844f31da7f9a11c783c84bdbbc80bd] libgui: Add ICS/MR0-compatible client::createSurface constructors

git bisect start
# good: [07e46014e34258f9ab43572a00598bd9b5fe6488] libgui: Add ICS/MR0-compatible client::createSurface constructors
git bisect good 07e46014e34258f9ab43572a00598bd9b5fe6488
# bad: [c0f52aabe2ab8c859c4f3a790f6c8b0ec40107ba] Revert "Revert "Compatibility work around for bad graphics driver dependency.""
git bisect bad c0f52aabe2ab8c859c4f3a790f6c8b0ec40107ba
# good: [02b95105754b1859a97e234b79f41489a4677c20] fix transitions from hwc to GLES composition
git bisect good 02b95105754b1859a97e234b79f41489a4677c20
# good: [f2108ee9f769c7c43aa42d7ba6e7989d891e3eb5] Revert "Revert "A vendor ril depends on a native screen shot code.""
git bisect good f2108ee9f769c7c43aa42d7ba6e7989d891e3eb5
# good: [2b77c3e473c4347e34d2fae9dcf32366fd629b33] exynos4: getphys implementation on buffermanager for samsung omx
git bisect good 2b77c3e473c4347e34d2fae9dcf32366fd629b33
# first bad commit: [c0f52aabe2ab8c859c4f3a790f6c8b0ec40107ba] Revert "Revert "Compatibility work around for bad graphics driver dependency.""

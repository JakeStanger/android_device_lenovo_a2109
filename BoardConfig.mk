# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

USE_CAMERA_STUB := false
# TARGET_RECOVERY_UI_LIB := librecovery_ui_a2109a
RECOVERY_FSTAB_VERSION := 2

# inherit from the proprietary version
-include vendor/lenovo/kai/BoardConfigVendor.mk

TARGET_BOARD_PLATFORM := tegra
TARGET_TEGRA_VERSION := t30

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9

TARGET_NO_RADIOIMAGE := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_BOOTLOADER_BOARD_NAME := a2109a

BOARD_KERNEL_CMDLINE := androidboot.selinux=enforcing androidboot.hardware=kai
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

TARGET_PREBUILT_KERNEL := device/lenovo/kai/kernel
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 671088640
# System partition might be too small, if so, disable journaling on system.img to save space.
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_USERDATAIMAGE_PARTITION_SIZE := 805306368
BOARD_FLASH_BLOCK_SIZE := 4096

# Custom Tools
#TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := device/lenovo/kai/releasetools/kai_ota_from_target_files

BOARD_HAVE_WIFI := true
# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE           := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"

TARGET_BOOTLOADER_BOARD_NAME := kai
#TARGET_BOARD_INFO_FILE := device/lenovo/kai/board-info.txt

TARGET_NO_BOOTLOADER := true

BOARD_USES_GENERIC_INVENSENSE := false

MALLOC_IMPL := dlmalloc

# Audio Options
BOARD_USES_GENERIC_AUDIO := false
# frameworks/native 43022aef331c665ebd9484893b0b0ebc2c523452:
BOARD_HAVE_PRE_KITKAT_AUDIO_BLOB := true
# frameworks/native ba3877845ec7b34fd13393aeed7ad74dcb727a4c:
BOARD_HAVE_PRE_KITKAT_AUDIO_POLICY_BLOB := true
USE_LEGACY_AUDIO_POLICY := true

### Defines for legacy blobs
# Marshmallow
TARGET_NEEDS_TEXT_RELOCS_SUPPORT := true
# COMMON_GLOBAL_CFLAGS += -DDISABLE_ASHMEM_TRACKING # Probably only needed for old RIL

# Taken from p880
# Probably unnecessary:
BOARD_USES_LEGACY_MMAP := true
# Probably unnecessary
COMMON_GLOBAL_CFLAGS += -DBOARD_CANT_REALLOCATE_OMX_BUFFERS
TARGET_REQUIRES_SYNCHRONOUS_SETSURFACE := true

# Needed in p880 to fix fullscreen video playback

# Used in tf300t, tf700t, htc-tegra3 and p880; Commit 0454961cfba4106e0a89c69630d0ddb6128b5280
COMMON_GLOBAL_CFLAGS += \
     -DMR0_CAMERA_BLOB

# Camera wrapper
TARGET_SPECIFIC_HEADER_PATH := device/lenovo/kai/include


# Kai HAL libraries
BOARD_HAL_STATIC_LIBRARIES := \
    libdumpstate.kai

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := device/lenovo/kai/bluetooth/vnd_kai.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/lenovo/kai/bluetooth

# Use Cortex A9 optimizations for A7
USE_ALL_OPTIMIZED_STRING_FUNCS := true

# Turn on Cortex A9 Optimizations for A7
TARGET_EXTRA_CFLAGS += $(call cc-option,-mtune=cortex-a9) $(call cc-option,-mcpu=cortex-a9)

# EGL
USE_OPENGL_RENDERER := true
# Used in tf300t, tf700t, p880
BOARD_HAVE_PIXEL_FORMAT_INFO := true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

# Used in htc-tegra3 and p880
BOARD_EGL_WORKAROUND_BUG_10194508 := true
BOARD_EGL_NEEDS_FNW := true
# Commit e65d285976712edb96a093d4a17aff83621785e5 (frameworks/native):
BOARD_EGL_SKIP_FIRST_DEQUEUE := true
# Commit ae4d80e4706d15c38944822486a4a92f2a2ec0f1 (frameworks/native):
BOARD_USE_MHEAP_SCREENSHOT := true
#TARGET_FORCE_SCREENSHOT_CPU_PATH := true # Commit c8e2624c618ec7348ab1b963cea95f5725c654c5 (frameworks/native)
#COMMON_GLOBAL_CFLAGS += -DFORCE_SCREENSHOT_CPU_PATH

ifneq ($(HAVE_NVIDIA_PROP_SRC),false)
# needed for source compilation of nvidia libraries
-include vendor/nvidia/proprietary_src/build/definitions.mk
-include vendor/nvidia/build/definitions.mk
endif

BOARD_SEPOLICY_DIRS := \
        device/lenovo/kai/sepolicy

# Avoid the generation of ldrcc instructions
NEED_WORKAROUND_CORTEX_A9_745320 := true

TARGET_RECOVERY_FSTAB = device/lenovo/kai/fstab.kai

# Required for CWM
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_RECOVERY_SWIPE := false

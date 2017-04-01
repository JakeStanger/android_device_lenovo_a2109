
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := audio.primary.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/hw
LOCAL_SRC_FILES := audio_hw.c
LOCAL_C_INCLUDES += \
	external/tinyalsa/include \
	external/expat/lib \
	system/media/audio_utils/include \
	system/media/audio_effects/include
LOCAL_CFLAGS := -Wall -Werror
LOCAL_SHARED_LIBRARIES := liblog libcutils libtinyalsa libaudioutils libexpat
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

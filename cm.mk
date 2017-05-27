# Release name
PRODUCT_RELEASE_NAME := a2109

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 800

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/lenovo/a2109/full_a2109.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := a2109
PRODUCT_NAME := cm_a2109
PRODUCT_BRAND := Ideatab
PRODUCT_MODEL := A2109A
PRODUCT_MANUFACTURER := Lenovo

# Don't restrict vendor folder
PRODUCT_RESTRICT_VENDOR_FILES := false

##Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=kai \
    BUILD_FINGERPRINT="Lenovo/IdeaTab_A2109A/A2109A:4.1.1/JRO03R/A2109A_A411_03_13_121126:user/release-keys" \
    PRIVATE_BUILD_DESC="kai-user 4.1.1 JRO03R A2109A_A411_03_13_121126 release-keys"

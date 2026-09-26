TARGET = iphone:clang:latest:16.0

INSTALL_TARGET_PROCESSES = YouTube

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AlasdStore_CN

AlasdStore_CN_FILES = Tweak.xm translate.m

AlasdStore_CN_CFLAGS = -fobjc-arc -Wno-unused-variable

include $(THEOS_MAKE_PATH)/tweak.mk

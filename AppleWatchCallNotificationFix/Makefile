ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TOOL_NAME = AppleWatchCallNotificationFix

AppleWatchCallNotificationFix_FILES = main.m
AppleWatchCallNotificationFix_CFLAGS = -fobjc-arc
AppleWatchCallNotificationFix_CODESIGN_FLAGS = -Sent.xml

include $(THEOS_MAKE_PATH)/tool.mk

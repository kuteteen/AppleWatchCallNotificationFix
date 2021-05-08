export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/

PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

export THEOS_DEVICE_IP=192.168.86.32
export ARCHS = arm64 arm64e
export TARGET = iphone:clang:13.0:13.0

TWEAK_NAME = AppleWatchCallNotificationFix
AppleWatchCallNotificationFix_FILES = Tweak.x
AppleWatchCallNotificationFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += AppleWatchCallNotificationFix
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"

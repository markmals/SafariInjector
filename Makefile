export TARGET = iphone:latest:13.0
export ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SafariInjector

SafariInjector_FILES = SafariInjector.x Utilities.m
SafariInjector_FRAMEWORKS = UIKit SafariServices
SafariInjector_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
SafariInjector_GENERATOR = internal

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS"
	install.exec "killall -9 MobileMail"
	install.exec "killall -9 MobileCal"
	install.exec "killall -9 Maps"
	install.exec "killall -9 MobileNotes"

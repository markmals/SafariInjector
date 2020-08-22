include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

TWEAK_NAME = SafariInjector
SafariInjector_FILES = $(wildcard *.x) $(wildcard *.m)
SafariInjector_FRAMEWORKS = UIKit SafariServices
SafariInjector_CFLAGS = -fobjc-arc
SafariInjector_GENERATOR = internal

after-install::
	install.exec "killall -9 MobileSMS"
	install.exec "killall -9 MobileMail"
	install.exec "killall -9 MobileCal"
	install.exec "killall -9 Maps"
	install.exec "killall -9 MobileNotes"
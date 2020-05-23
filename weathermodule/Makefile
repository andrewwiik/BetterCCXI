include $(THEOS)/makefiles/common.mk

export TARGET = iphone:latest:7.0
export ARCHS = arm64 arm64e

BUNDLE_NAME = BCIXWeatherModule
BCIXWeatherModule_BUNDLE_EXTENSION = bundle
BCIXWeatherModule_FILES = $(wildcard *.m) $(wildcard *.xm)
BCIXWeatherModule_LDFLAGS += ./ControlCenterUIKit.tbd
BCIXWeatherModule_INSTALL_PATH = /Library/ControlCenter/Bundles/
BCIXWeatherModule_CFLAGS += -fobjc-arc

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk

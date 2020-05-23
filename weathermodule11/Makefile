include $(THEOS)/makefiles/common.mk

export TARGET = iphone:latest:7.0
export ARCHS = arm64 arm64e

BUNDLE_NAME = BCIXWeatherModule11
BCIXWeatherModule11_BUNDLE_EXTENSION = bundle
BCIXWeatherModule11_FILES = $(wildcard *.m) $(wildcard *.xm)
BCIXWeatherModule11_LDFLAGS += ./ControlCenterUIKit.tbd
BCIXWeatherModule11_INSTALL_PATH = /Library/ControlCenter/Bundles/
BCIXWeatherModule11_CFLAGS += -fobjc-arc

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk

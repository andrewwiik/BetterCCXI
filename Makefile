ifeq ($(SIMULATOR),1)
	export TARGET = simulator:latest:7.0
else
	export TARGET = iphone:latest:7.0
	export ARCHS = arm64 arm64e
endif

export ADDITIONAL_LDFLAGS = -F$(THEOS_OBJ_DIR) $(THEOS)/vendor/lib/libsubstrate.tbd
export ADDITIONAL_CFLAGS = -fobjc-arc -I$(THEOS_PROJECT_DIR)/headers -I$(THEOS_PROJECT_DIR)/

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BetterCCXI
BetterCCXI_FILES = $(wildcard *.m) $(wildcard *.xm)
BetterCCXI_LDFLAGS += ./MediaControls.tbd

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += Settings
SUBPROJECTS += weathermodule11
include $(THEOS_MAKE_PATH)/aggregate.mk

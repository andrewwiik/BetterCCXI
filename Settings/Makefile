include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BetterCCXI
BetterCCXI_FILES = BCMRootListController.m
BetterCCXI_INSTALL_PATH = /Library/PreferenceBundles
BetterCCXI_FRAMEWORKS = UIKit
BetterCCXI_LDFLAGS += ./Preferences.tbd

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BetterCCXI.plist$(ECHO_END)

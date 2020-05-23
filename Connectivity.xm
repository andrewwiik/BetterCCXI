@interface CCUIConnectivityModuleViewController : UIViewController
- (BOOL)isExpanded;
- (NSArray<UIViewController *> *)buttonViewControllers;
- (NSArray<UIViewController *> *)landscapeButtonViewControllers;
- (NSArray<UIViewController *> *)portraitButtonViewControllers;
- (BOOL)_isPortrait;
- (CGSize)_compressedButtonSize;
@end

@interface CCUIConnectivityModuleViewController (BCM)
- (NSInteger)numOfColsCompressed;
- (NSInteger)numOfRowsCompressed;
@end

@interface CCUIModuleViewController : UIViewController
- (void)expandModule;
- (BOOL)isExpanded;
@end

@interface CCUIConnectivityAirDropViewController : UIViewController
@end

#include <CoreFoundation/CoreFoundation.h>
#include <notify.h>
#import <macros.h>

static NSMutableDictionary *globalSettings;
static NSInteger connectModSizeOption = 1;

%group ConnectivityModule
%hook CCUIConnectivityModuleViewController
- (void)viewWillLayoutSubviews {
	%orig;
	if (![self isExpanded]) {

		NSArray<UIViewController *> *viewControllers = nil;
		if ([self _isPortrait]) viewControllers = [self portraitButtonViewControllers];
		else viewControllers = [self landscapeButtonViewControllers];
		if (viewControllers) {
			CGSize buttonSize = [self _compressedButtonSize];
			NSInteger colCount = [self numOfColsCompressed];
			if (colCount > [viewControllers count]) colCount = [viewControllers count];
			NSInteger rowCount = [self numOfRowsCompressed];
			CGFloat horizontalSpacing = (self.view.bounds.size.width - (buttonSize.width * colCount))/(2 + (colCount - 1));
			CGFloat verticalSpacing = (self.view.bounds.size.height - (buttonSize.height * rowCount))/(2 + (rowCount - 1));

			NSInteger buttonCount = [viewControllers count];
			NSInteger maxButtonShow = rowCount*colCount;
			BOOL shouldBreak = NO;
			for (NSInteger r = 0; r < rowCount; r++) {
				if (shouldBreak) break;
				for (NSInteger c = 0; c < colCount; c++) {
					NSInteger index = r*colCount+c;
					if (index < buttonCount && index < maxButtonShow) {
						CGFloat yOrigin = (verticalSpacing*(1 + r))+(r*buttonSize.height);
						CGFloat xOrigin = (horizontalSpacing*(1 + c))+(c*buttonSize.width);
						CGRect frame = CGRectMake(xOrigin, yOrigin, 0,0);
						frame.size = buttonSize;

						UIView *buttonView = ((UIViewController *)[viewControllers objectAtIndex:index]).view;
						if (buttonView) {
							buttonView.alpha = 1.0;
							buttonView.frame = frame;
						}
					} else {
						shouldBreak = YES;
						break;
					}

				}
			}

		}
	}
}

// - (BOOL)isExpanded {
// 	if (shouldFake) return YES;
// 	return %orig;
// }

%new
- (NSInteger)numOfColsCompressed {
	if (connectModSizeOption == 1) return 5;
	if (connectModSizeOption == 2) return 3;
	if (connectModSizeOption == 3) return 2;
	if (connectModSizeOption == 4) return 2;
	return 2;
}

%new
- (NSInteger)numOfRowsCompressed {
	if (connectModSizeOption == 1) return 1;
	if (connectModSizeOption == 2) return 2;
	if (connectModSizeOption == 3) return 3;
	if (connectModSizeOption == 4) return 2;
	return 3;
}

// -(NSUInteger)_numRowsWhenExpanded {
// 	return 2;
// }
%end


%hook CCUIConnectivityAirDropViewController
- (void)buttonTapped:(id)button {
	if (isPad) {
		%orig;
	} else {
		UIViewController *p1 = self.parentViewController;
		if (p1) {
			UIViewController *p2 = p1.parentViewController;
			if (p2) {
				if ([p2 isKindOfClass:NSClassFromString(@"CCUIContentModuleContainerViewController")]) {
					CCUIModuleViewController *modController = (CCUIModuleViewController *)p2;
					if ([modController isExpanded] == NO) {
						[modController expandModule];
					}
				}
			}
		}
		%orig;
	}
}
%end
%end

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	if ([((__bridge NSDictionary *)userInfo)[NSLoadedClasses] containsObject:@"CCUIConnectivityModuleViewController"]) { // The Network Bundle is Loaded
		%init(ConnectivityModule);
	}
}

static void loadSettings() {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", @"com.atwiiks.betterccxi"];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];

	globalSettings = settings;

	connectModSizeOption = (NSInteger)[[globalSettings objectForKey:@"connectModuleSize"]?:@1 integerValue];
}

%ctor {
	CFNotificationCenterAddObserver(
			CFNotificationCenterGetLocalCenter(), NULL,
			notificationCallback,
			(CFStringRef)NSBundleDidLoadNotification,
			NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadSettings();
	%init;

}


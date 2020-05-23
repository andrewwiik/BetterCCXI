#import <Weather/WATodayHeaderView.h>

@interface WATodayHeaderView ()
@property (nonatomic, assign) BOOL isBCIWeatherView;
@end

@interface UIColor ()
-(CGFloat)alphaComponent;
@end

static BOOL hasWeatherBG = NO;

%hook WATodayHeaderView
%property (nonatomic, assign) BOOL isBCIWeatherView;

- (id)init {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", @"com.atwiiks.betterccxi"];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];

	hasWeatherBG = (BOOL)[[settings objectForKey:@"useLiveWeatherBG"]?:@NO boolValue];
	if (!NSClassFromString(@"WUIDynamicWeatherBackground")) hasWeatherBG = NO;
	id orig = %orig;
	return orig;
}

- (void)_updateContent {
	%orig;
	if (self.isBCIWeatherView) {
		// CGRect frame = self.frame;
		// frame.size.height = 80;
		// self.frame = frame;
		NSArray<UIView *> *subviews = [self subviews];
		if (subviews) {
			for (UIView *view in subviews) {
				if ([view isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
					UIVisualEffectView *effectView = (UIVisualEffectView *)view;
					if (effectView) {
						NSArray<UIView *> *effectViews = [effectView.contentView subviews];
						if (effectViews) {
							for (UIView *subview in effectViews) {
								if ([subview isKindOfClass:NSClassFromString(@"UILabel")]) {
									UILabel *label = (UILabel *)subview;
									label.textColor = [UIColor colorWithWhite:1.0 alpha:hasWeatherBG ? 1.0 : [label.textColor alphaComponent]];
								}
							}
						}

						[effectView setEffect:nil];
					}
				}
			}
		}
	}
}
%end

%ctor {
	if (!NSClassFromString(@"WUIDynamicWeatherBackground")) dlopen("/System/Library/PrivateFrameworks/WeatherUI.framework/WeatherUI", RTLD_NOW);
	%init;
}
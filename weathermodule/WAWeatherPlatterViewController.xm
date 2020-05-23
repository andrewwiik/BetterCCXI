#import <Weather/WAWeatherPlatterViewController.h>

@interface WAWeatherPlatterViewController ()
@property (nonatomic, assign) BOOL isBCIWeatherView;
@property (nonatomic, retain) UIView *dividerView;
@end

@interface UIColor ()
-(CGFloat)alphaComponent;
@end

static BOOL hasWeatherBG = NO;

%hook WAWeatherPlatterViewController
%property (nonatomic, assign) BOOL isBCIWeatherView;
%property (nonatomic, retain) UIView *dividerView;


- (id)init {


	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", @"com.atwiiks.betterccxi"];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];

	hasWeatherBG = (BOOL)[[settings objectForKey:@"useLiveWeatherBG"]?:@NO boolValue];
	if (!NSClassFromString(@"WUIDynamicWeatherBackground")) hasWeatherBG = NO;
	id orig = %orig;
	return orig;
}

-(void)setStatus:(NSInteger)status {
	%orig;
	// if (self.isBCIWeatherView) {

	// 	if (self.dividerLineView) {
	// 		if (!self.dividerView) {
	// 			self.dividerView =[[UIView alloc] initWithFrame:self.dividerLineView.frame];
	// 			self.dividerView.backgroundColor = [UIColor whiteColor];
	// 			[self.view addSubview:self.dividerView];
	// 		}
	// 		if (self.dividerView) {
	// 			CGRect frame = self.dividerLineView.frame;
	// 			frame.origin.x = 0;
	// 			frame.size.width = self.view.bounds.size.width;
	// 			self.dividerView.frame = frame;
	// 		}
	// 		self.dividerLineView.hidden = YES;
	// 		self.dividerLineView.alpha = 0.0;
	// 		// UIView *divider = self.dividerLineView;
	// 		// //divider.translatesAutoresizingMaskIntoConstraints = YES;
	// 		// CGRect frame = divider.frame;
	// 		// frame.origin.x = 0;
	// 		// frame.origin.y = self.headerView.frame.size.height;
	// 		// frame.size.height = 1.0/[UIScreen mainScreen].scale;
	// 		// frame.size.width = self.view.bounds.size.width;
	// 		// divider.frame = frame;
	// 		// divider.backgroundColor = [UIColor whiteColor];

	// 	}
	// 	NSArray<UIView *> *forecastViews = self.hourlyForecastViews;
	// 	if (forecastViews) {
	// 		for (UIView *forecastView in forecastViews) {
	// 			NSArray<UIView *> *subviews = [forecastView subviews];
	// 			if (subviews) {
	// 				for (UIView *view in subviews) {
	// 					if ([view isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
	// 						UIVisualEffectView *effectView = (UIVisualEffectView *)view;
	// 						if (effectView) {
	// 							NSArray<UIView *> *effectViews = [effectView.contentView subviews];
	// 							if (effectViews) {
	// 								for (UIView *subview in effectViews) {
	// 									if ([subview isKindOfClass:NSClassFromString(@"UILabel")]) {
	// 										UILabel *label = (UILabel *)subview;
	// 										label.textColor = [UIColor colorWithWhite:1.0 alpha:hasWeatherBG ? 1.0 : [label.textColor alphaComponent]];
	// 									}
	// 								}
	// 							}

	// 							[effectView setEffect:nil];
	// 						}
	// 					}
	// 				}
	// 			}
	// 		}
	// 	}
	// }
}

// - (void)viewWillLayoutSubviews {

// }

- (void)_updateViewContent {
	// if (self.isBCIWeatherView) {

	// 	if (self.dividerLineView) {
	// 		if (!self.dividerView) {
	// 			self.dividerView =[[UIView alloc] initWithFrame:self.dividerLineView.frame];
	// 			self.dividerView.backgroundColor = [UIColor whiteColor];
	// 			[self.view addSubview:self.dividerView];
	// 		}
	// 		if (self.dividerView) {
	// 			CGRect frame = self.dividerLineView.frame;
	// 			frame.origin.x = 0;
	// 			frame.size.width = self.view.bounds.size.width;
	// 			self.dividerView.frame = frame;
	// 		}
	// 		self.dividerLineView.hidden = YES;
	// 		self.dividerLineView.alpha = 0.0;
	// 		// UIView *divider = self.dividerLineView;
	// 		// //divider.translatesAutoresizingMaskIntoConstraints = YES;
	// 		// CGRect frame = divider.frame;
	// 		// frame.origin.x = 0;
	// 		// frame.origin.y = self.headerView.frame.size.height;
	// 		// frame.size.height = 1.0/[UIScreen mainScreen].scale;
	// 		// frame.size.width = self.view.bounds.size.width;
	// 		// divider.frame = frame;
	// 		// divider.backgroundColor = [UIColor whiteColor];

	// 	}
	// 	NSArray<UIView *> *forecastViews = self.hourlyForecastViews;
	// 	if (forecastViews) {
	// 		for (UIView *forecastView in forecastViews) {
	// 			NSArray<UIView *> *subviews = [forecastView subviews];
	// 			if (subviews) {
	// 				for (UIView *view in subviews) {
	// 					if ([view isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
	// 						UIVisualEffectView *effectView = (UIVisualEffectView *)view;
	// 						if (effectView) {
	// 							NSArray<UIView *> *effectViews = [effectView.contentView subviews];
	// 							if (effectViews) {
	// 								for (UIView *subview in effectViews) {
	// 									if ([subview isKindOfClass:NSClassFromString(@"UILabel")]) {
	// 										UILabel *label = (UILabel *)subview;
	// 										label.textColor = [UIColor colorWithWhite:1.0 alpha:hasWeatherBG ? 1.0 : [label.textColor alphaComponent]];
	// 									}
	// 								}
	// 							}

	// 							[effectView setEffect:nil];
	// 						}
	// 					}
	// 				}
	// 			}
	// 		}
	// 	}
	// }
	// %orig;
	// if (self.isBCIWeatherView) {

	// 	if (self.dividerLineView) {
	// 		if (!self.dividerView) {
	// 			self.dividerView =[[UIView alloc] initWithFrame:self.dividerLineView.frame];
	// 			self.dividerView.backgroundColor = [UIColor whiteColor];
	// 			[self.view addSubview:self.dividerView];
	// 		}
	// 		if (self.dividerView) {
	// 			CGRect frame = self.dividerLineView.frame;
	// 			frame.origin.x = 0;
	// 			frame.size.width = self.view.bounds.size.width;
	// 			self.dividerView.frame = frame;
	// 		}
	// 		self.dividerLineView.hidden = YES;
	// 		self.dividerLineView.alpha = 0.0;
	// 		// UIView *divider = self.dividerLineView;
	// 		// //divider.translatesAutoresizingMaskIntoConstraints = YES;
	// 		// CGRect frame = divider.frame;
	// 		// frame.origin.x = 0;
	// 		// frame.origin.y = self.headerView.frame.size.height;
	// 		// frame.size.height = 1.0/[UIScreen mainScreen].scale;
	// 		// frame.size.width = self.view.bounds.size.width;
	// 		// divider.frame = frame;
	// 		// divider.backgroundColor = [UIColor whiteColor];

	// 	}
	// 	NSArray<UIView *> *forecastViews = self.hourlyForecastViews;
	// 	if (forecastViews) {
	// 		for (UIView *forecastView in forecastViews) {
	// 			NSArray<UIView *> *subviews = [forecastView subviews];
	// 			if (subviews) {
	// 				for (UIView *view in subviews) {
	// 					if ([view isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
	// 						UIVisualEffectView *effectView = (UIVisualEffectView *)view;
	// 						if (effectView) {
	// 							NSArray<UIView *> *effectViews = [effectView.contentView subviews];
	// 							if (effectViews) {
	// 								for (UIView *subview in effectViews) {
	// 									if ([subview isKindOfClass:NSClassFromString(@"UILabel")]) {
	// 										UILabel *label = (UILabel *)subview;
	// 										label.textColor = [UIColor colorWithWhite:1.0 alpha:hasWeatherBG ? 1.0 : [label.textColor alphaComponent]];
	// 									}
	// 								}
	// 							}

	// 							[effectView setEffect:nil];
	// 						}
	// 					}
	// 				}
	// 			}
	// 		}
	// 	}
	// }
	@try {
		%orig;
    } @catch ( NSException *e ) {
    	NSLog(@"Got Exception: %@", e);
	}
}


- (void)viewWillLayoutSubviews {
	%orig;
	if (self.isBCIWeatherView) {

		if (self.dividerLineView) {
			if (!self.dividerView) {
				self.dividerView =[[UIView alloc] initWithFrame:self.dividerLineView.frame];
				self.dividerView.backgroundColor = [UIColor whiteColor];
				[self.view addSubview:self.dividerView];
			}
			if (self.dividerView) {
				CGRect frame = self.dividerLineView.frame;
				frame.origin.x = 0;
				frame.size.width = self.view.bounds.size.width;
				self.dividerView.frame = frame;
			}
			self.dividerLineView.hidden = YES;
			self.dividerLineView.alpha = 0.0;
		}
	}

	if (self.isBCIWeatherView) {

		if (self.dividerLineView) {
			if (!self.dividerView) {
				self.dividerView =[[UIView alloc] initWithFrame:self.dividerLineView.frame];
				self.dividerView.backgroundColor = [UIColor whiteColor];
				[self.view addSubview:self.dividerView];
			}
			if (self.dividerView) {
				CGRect frame = self.dividerLineView.frame;
				frame.origin.x = 0;
				frame.size.width = self.view.bounds.size.width;
				self.dividerView.frame = frame;
			}
			self.dividerLineView.hidden = YES;
			self.dividerLineView.alpha = 0.0;
			// UIView *divider = self.dividerLineView;
			// //divider.translatesAutoresizingMaskIntoConstraints = YES;
			// CGRect frame = divider.frame;
			// frame.origin.x = 0;
			// frame.origin.y = self.headerView.frame.size.height;
			// frame.size.height = 1.0/[UIScreen mainScreen].scale;
			// frame.size.width = self.view.bounds.size.width;
			// divider.frame = frame;
			// divider.backgroundColor = [UIColor whiteColor];

		}
		NSArray<UIView *> *forecastViews = self.hourlyForecastViews;
		if (forecastViews) {
			for (UIView *forecastView in forecastViews) {
				NSArray<UIView *> *subviews = [forecastView subviews];
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
	}
}
%end

// %hook __NSArrayM

// - (void)removeAllObjects {
// 	@try {
// 		%orig;
//     } @catch ( NSException *e ) {
// 	}
// }
// %end
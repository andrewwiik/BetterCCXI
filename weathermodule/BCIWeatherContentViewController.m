#import "BCIWeatherContentViewController.h"
#import <WeatherUI/WUIDynamicWeatherBackground.h>
#import <UIKit/UIView+Private2.h>

@interface WATodayHeaderView ()
@property (nonatomic, assign) BOOL isBCIWeatherView;
@end

@interface WAWeatherPlatterViewController ()
@property (nonatomic, assign) BOOL isBCIWeatherView;
@end



static BOOL hasWeatherBG = NO;


@implementation BCIWeatherContentViewController
- (id)init {
	self = [super init];
	if (self) {
		NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", @"com.atwiiks.betterccxi"];
		NSMutableDictionary *settings = [NSMutableDictionary dictionary];
		[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];

		hasWeatherBG = (BOOL)[[settings objectForKey:@"useLiveWeatherBG"]?:@NO boolValue];
		if (!NSClassFromString(@"WUIDynamicWeatherBackground")) hasWeatherBG = NO;
		_lockscreenController = [[NSClassFromString(@"WALockscreenWidgetViewController") alloc] init];
		[_lockscreenController viewWillAppear:TRUE];
		[_lockscreenController viewDidAppear:TRUE];
		_weatherModel = (WATodayAutoupdatingLocationModel *)_lockscreenController.todayModel;
		// [_weatherModel setLocationServicesActive:YES];
    // [_weatherModel setIsLocationTrackingEnabled:YES];
		[_weatherModel addObserver:self];

		// if (!NSClassFromString(@"WUIDynamicWeatherBackground")) dlopen("/System/Library/PrivateFrameworks/WeatherUI.framework/WeatherUI", RTLD_NOW);
	}
	return self;
}

-(BOOL)shouldFinishTransitionToExpandedContentModule {
	return YES;
}

-(CGFloat)preferredExpandedContentHeight {
	return 200.0;
}

-(void)todayModelWantsUpdate:(WATodayModel *)model {
	return;
}

-(void)didTransitionToExpandedContentMode:(BOOL)arg1 {
	if (_platterController) {
		_platterController.view.frame = self.view.bounds;
		[_platterController _contentSizeDidUpdate:nil];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	if (!_platterController) {
		_platterController = [[NSClassFromString(@"WAWeatherPlatterViewController") alloc] init];
		_platterController.isBCIWeatherView = YES;
		[_platterController setModel:_weatherModel];
		[self addChildViewController: _platterController];
		_platterController.isBCIWeatherView = YES;
		if (_platterController.headerView) {
			_platterController.headerView.isBCIWeatherView = YES;
			[_platterController.headerView _updateContent];
		}
		_platterController.view.frame = self.view.bounds;
		[_platterController _contentSizeDidUpdate:nil];

		[self.view addSubview: _platterController.view];
		[_platterController didMoveToParentViewController:self];

		if (_platterController.headerView && _platterController.headerView.isBCIWeatherView == NO) {
			_platterController.headerView.isBCIWeatherView = YES;
			[_platterController.headerView _updateContent];
		}
		//[_platterController _updateViewContent];
	}

	if (!_weatherView && NSClassFromString(@"WUIDynamicWeatherBackground") && hasWeatherBG) {
		_weatherView = [[NSClassFromString(@"WUIDynamicWeatherBackground") alloc] init];
		[self.view addSubview:_weatherView];
		[self.view sendSubviewToBack:_weatherView];
		[(WUIDynamicWeatherBackground *)_weatherView animateTransitionToSize:self.view.bounds.size];
		if ([_weatherModel forecastModel]) {
			if ([_weatherModel forecastModel].city) {
				[(WUIDynamicWeatherBackground *)_weatherView setCity:[_weatherModel forecastModel].city animate:YES];
			}
		}
	}

	// if (_platterController)

	// if (_forecast) {
	// 	[_platterController _buildModelForLocation:_forecast.location];
	// }
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	if (_weatherView) {
		_weatherView.frame = self.view.bounds;
		[(WUIDynamicWeatherBackground *)_weatherView animateTransitionToSize:self.view.bounds.size];
		[self.view sendSubviewToBack:_weatherView];
		_weatherView.clipsToBounds = YES;
		UIView *superview = [self.view superview];
		if (superview) {
			NSArray<UIView *> *topSubviews = [superview subviews];
			if (topSubviews) {
				for (UIView *topSub in topSubviews) {
					if ([topSub isKindOfClass:NSClassFromString(@"MTMaterialView")]) {
						NSArray<UIView *> *subviews = [topSub subviews];
						if (subviews) {
							for (UIView *subview in subviews) {
								if ([subview isKindOfClass:NSClassFromString(@"_MTBackdropView")]) {
									_weatherView._continuousCornerRadius = subview._continuousCornerRadius;
								}
							}
						}
					}
				}
			}
		}
	}
	if (_platterController) {
		CGRect frame = self.view.bounds;
		if (frame.size.height < 163) {
			frame.size.height = 163;
			if (self.view.bounds.size.height < 90) {
				frame.origin.y = 0 - ((83 - self.view.bounds.size.height)/2);
			}
			self.view.clipsToBounds = YES;
		}
		// if (self.view.bounds.size.height >= [self preferredExpandedContentHeight]) {
		// 	frame.size.height -= 10;
		// }
		// frame.size.width = self.view.bounds.size.width * 2;
		// frame.size.height = self.view.bounds.size.height * 2;
		_platterController.view.frame = frame;
		// [_platterController _contentSizeDidUpdate:nil];
		//[_platterController _contentSizeDidUpdate:nil];
		// _platterController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
		if (_platterController.headerView && _platterController.headerView.isBCIWeatherView != YES) {
			_platterController.headerView.isBCIWeatherView = YES;
			[_platterController.headerView _updateContent];
		}
		NSArray<UIView *> *mainSubviews = [_platterController.view subviews];
		if (mainSubviews) {
			for (UIView *view in mainSubviews) {
				if ([view isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
					view.alpha = 0.0;
					view.hidden = YES;
					view.frame = CGRectZero;
				}
			}
		}

		// NSArray<UIView *> *forecastViews = _platterController.hourlyForecastViews;
		// for (UIView *forecastView in forecastViews) {
		// 	NSArray<UIView *> *subviews = [forecastView subviews];
		// 	for (UIView *view in subviews) {
		// 		if ([view isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
		// 			UIVisualEffectView *effectView = (UIVisualEffectView *)view;
		// 			NSArray<UIView *> *effectViews = [effectView.contentView subviews];
		// 			for (UIView *subview in effectViews) {
		// 				if ([subview isKindOfClass:NSClassFromString(@"UILabel")]) {
		// 					UILabel *label = (UILabel *)subview;
		// 					label.textColor = [UIColor colorWithWhite:1.0 alpha:[label.textColor alpha]];
		// 				}
		// 			}

		// 			[effectView setEffect:nil];
		// 		}
		// 	}
		// }
	}
}

-(void)todayModel:(WATodayModel *)model forecastWasUpdated:(WAForecastModel *)forecast {
	_forecast = forecast;
	if (_forecast) {

		if (_weatherView) {
			if ([_weatherModel forecastModel]) {
				if ([_weatherModel forecastModel].city) {
					[(WUIDynamicWeatherBackground *)_weatherView setCity:[_weatherModel forecastModel].city animate:YES];
				}
			}
		}
		// }
		if (_platterController) {
			if (_platterController.headerView) {
				if (_platterController.headerView.isBCIWeatherView == NO) {
					_platterController.headerView.isBCIWeatherView = YES;
					[_platterController.headerView _updateContent];
				}
			}
			[_platterController _updateViewContent];
			_platterController.isBCIWeatherView = YES;
		}
 	}
	return;
}

-(void)willBecomeActive {
	if (_weatherModel) {
		[_weatherModel _kickstartLocationManager];
		[_weatherModel _reloadForecastData:YES];
		[_weatherModel _executeLocationUpdateWithCompletion:^{

		}];
		[_weatherModel executeModelUpdateWithCompletion:^{
		}];
	}
}

-(void)controlCenterWillPresent {
	if (_weatherModel) {
		[_weatherModel _kickstartLocationManager];
		[_weatherModel _reloadForecastData:YES];
		[_weatherModel _executeLocationUpdateWithCompletion:^{

		}];
		[_weatherModel executeModelUpdateWithCompletion:^{
		}];
	}
}
@end

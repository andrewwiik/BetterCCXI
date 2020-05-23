#import <Weather/Weather.h>
#import <ControlCenterUIKit/CCUIContentModuleContentViewController-Protocol.h>
#import <Weather/WATodayModelObserver-Protocol.h>
#import <Weather/WAWeatherPlatterViewController.h>
#import <Weather/WeatherView.h>

@interface WATodayPadView : UIView
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic,retain) UIView * locationLabel;                       //@synthesize locationLabel=_locationLabel - In the implementation block
@property (nonatomic,retain) UIView * conditionsLabel;  
@end

@interface WALockscreenWidgetViewController : UIViewController
@property (nonatomic,retain) WATodayModel * todayModel;
@end

@interface BCIWeatherContentViewController : UIViewController <CCUIContentModuleContentViewController, WATodayModelObserver> {
	WAWeatherPlatterViewController *_platterController;
	UIView *_weatherView;
	WALockscreenWidgetViewController *_lockscreenController;

}
@property (nonatomic, retain, readwrite) WAForecastModel *forecast;
@property (nonatomic, retain, readwrite) WATodayAutoupdatingLocationModel *weatherModel;
- (id)init;
- (BOOL)shouldFinishTransitionToExpandedContentModule;
- (CGFloat)preferredExpandedContentHeight;
- (void)todayModelWantsUpdate:(WATodayModel *)model;
- (void)todayModel:(WATodayModel *)model forecastWasUpdated:(WAForecastModel *)forecast;
@end

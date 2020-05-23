#import <ControlCenterUIKit/CCUIContentModule-Protocol.h>
#import "BCIWeatherContentViewController.h"

@interface BCIXWeatherModule : NSObject <CCUIContentModule> {
	BCIWeatherContentViewController *_contentViewController;
}
//This is what controls the view for the default UIElements that will appear before the module is expanded
@property (nonatomic, readonly) BCIWeatherContentViewController *contentViewController;
//This is what will control how the module changes when it is expanded
- (BCIWeatherContentViewController *)contentViewController;
@end
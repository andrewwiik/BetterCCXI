#import "WGWidgetPlatterView.h"
@interface WGWidgetViewController : UIViewController
@property (nonatomic, retain) WGWidgetPlatterView *view;
- (WGWidgetPlatterView *)view;
- (void)setView:(WGWidgetPlatterView *)view;
@end
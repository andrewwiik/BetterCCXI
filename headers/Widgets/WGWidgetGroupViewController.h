#import "WGMajorListViewController.h"

@interface WGWidgetGroupViewController : UIViewController {
	WGMajorListViewController* _majorColumnListViewController;
}
-(id)initWithWidgetDiscoveryController:(id)arg1 ;
-(void)_loadWidgetListViewController;
@end

@interface WGWidgetGroupViewController (ORHWidgetProvider)
- (UIViewController *)listViewController;
@end

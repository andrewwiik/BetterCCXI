#import "WGWidgetViewController.h"

@interface WGWidgetDiscoveryController : NSObject {
	NSMutableDictionary* _identifiersToWidgetInfos;
}
- (id)init;
- (void)beginDiscovery;
- (WGWidgetViewController *)_widgetViewControllerWithBundleID:(NSString *)bundleID containingBundleID:(NSString *)bundleID didConnect:(id)didConnect canTearDown:(id)canTearDown;
@end

@interface WGWidgetDiscoveryController (ORHWidgetProvider)
- (NSMutableDictionary *)identifiersToWidgetInfos;
@end
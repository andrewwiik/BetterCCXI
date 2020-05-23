#import <MaterialKit/MTTitledPlatterView.h>
@interface WGWidgetPlatterView : MTTitledPlatterView
@end

@interface WGWidgetPlatterView (ORHWidgetProvider)
@property (nonatomic, assign) BOOL isORHWidgetView;
@end
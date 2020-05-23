@interface SBFTouchPassThroughWindow : UIWindow
+ (Class)touchPassThroughRootViewControllerClass;
- (id)initWithFrame:(CGRect)frame;
- (id)hitTest:(CGPoint)point withEvent:(id)event;
- (id)initWithScreen:(UIScreen *)screen debugName:(NSString *)debugName;
@end
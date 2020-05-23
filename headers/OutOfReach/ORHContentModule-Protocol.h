@protocol ORHContentModule <NSObject>
@property(readonly, nonatomic) UIViewController *contentViewController;

@optional
+ (BOOL)isSupported;
@end
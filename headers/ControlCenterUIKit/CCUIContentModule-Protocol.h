#import "CCUIContentModuleContentViewController-Protocol.h"

@protocol CCUIContentModule <NSObject>
@optional
-(void)setContentModuleContext:(id)arg1;
-(UIViewController *)backgroundViewController;

@required
-(UIViewController<CCUIContentModuleContentViewController> *)contentViewController;

@end
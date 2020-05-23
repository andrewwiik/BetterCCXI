
#import <Foundation/NSObject.h>

@protocol CCUIContentModuleContentViewController <NSObject>
@optional
-(BOOL)shouldBeginTransitionToExpandedContentModule;
-(void)willResignActive;
-(void)willBecomeActive;
-(void)willTransitionToExpandedContentMode:(BOOL)arg1;
-(BOOL)shouldFinishTransitionToExpandedContentModule;
-(void)didTransitionToExpandedContentMode:(BOOL)arg1;
-(BOOL)canDismissPresentedContent;
-(void)dismissPresentedContentAnimated:(BOOL)arg1 completion:(/*^block*/id)arg2;
-(CGFloat)preferredExpandedContentWidth;
-(BOOL)providesOwnPlatter;
-(void)controlCenterWillPresent;
-(void)controlCenterDidDismiss;

@required
-(CGFloat)preferredExpandedContentHeight;

@end

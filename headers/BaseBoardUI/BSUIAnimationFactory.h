@interface BSUIAnimationFactory : NSObject
+ (id)factoryWithSettings:(id)arg1 ;
+ (void)animateWithFactory:(id)factory actions:(void (^)(void))actions;
+ (void)animateWithFactory:(id)factory actions:(void (^)(void))actions completion:(void (^)(BOOL completed))completion;
@end
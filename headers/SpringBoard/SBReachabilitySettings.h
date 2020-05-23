#import <SpringBoard/SBUISettings.h>

@interface SBReachabilitySettings : SBUISettings
-(id)animationFactory;
-(CGFloat)damping;
-(CGFloat)epsilon;
-(CGFloat)mass;
-(CGFloat)yOffset;
-(CGFloat)stiffness;
-(CGFloat)yOffsetFactor;
@end
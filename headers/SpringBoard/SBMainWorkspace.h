#import <SpringBoard/SBWorkspace.h>
#import <SpringBoard/SBWindow.h>

@interface SBMainWorkspace : SBWorkspace {
	SBWindow* _reachabilityWindow;
	SBWindow* _reachabilityEffectWindow;
}

+(instancetype)_instanceIfExists;
+(instancetype)sharedInstance;
@end
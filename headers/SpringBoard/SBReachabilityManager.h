@interface SBReachabilityManager : NSObject
@property (nonatomic,readonly) BOOL reachabilityModeActive;
@property (assign,nonatomic) BOOL reachabilityEnabled;
+ (instancetype)sharedInstance;
- (void)_handleReachabilityActivated;
- (void)_handleReachabilityDeactivated;
- (void)_handleSignificantTimeChanged;
- (void)_toggleReachabilityModeWithRequestingObserver:(id)observer;
- (void)toggleReachability;
- (void)_notifyObserversReachabilityModeActive:(BOOL)isActive excludingObserver:(id)observer;
@end
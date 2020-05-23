#import <UIKit/_UISettings.h>

@interface SBUISettings : _UISettings
-(void)setDefaultValues;
-(void)removeKeyPathObserver:(id)arg1;
-(void)removeKeyObserver:(id)arg1;
-(void)addKeyObserverIfPrototyping:(id)arg1 ;
-(void)addKeyPathObserverIfPrototyping:(id)arg1 ;
-(void)_prototypingIsAllowedSettingChanged:(id)arg1 ;
-(BOOL)_isPrototypingEnabled:(id)arg1 ;
@end

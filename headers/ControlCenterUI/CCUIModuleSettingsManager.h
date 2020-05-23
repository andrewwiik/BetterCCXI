#import "CCUIModuleSettings.h"
#import "ControlCenterUI-Structs.h"

@interface CCUIModuleSettingsManager : NSObject {
	NSDictionary* _settingsByIdentifier;
	NSHashTable* _observers;

}
-(id)init;
-(void)addObserver:(id)arg1 ;
-(void)removeObserver:(id)arg1 ;
-(id)orderedEnabledModuleIdentifiers;
-(id)sortModuleIdentifiers:(id)arg1 forInterfaceOrientation:(NSInteger)arg2 ;
-(id)moduleSettingsForModuleIdentifier:(NSString *)identifier prototypeSize:(CCUILayoutSize)protoSize;
-(void)_loadSettings;
-(void)_runBlockOnListeners:(/*^block*/id)arg1 ;
-(void)orderedEnabledModuleIdentifiersChangedForSettingsProvider:(id)arg1 ;
@end
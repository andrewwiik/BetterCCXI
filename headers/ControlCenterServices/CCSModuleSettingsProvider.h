@interface CCSModuleSettingsProvider : NSObject
+(void)initialize;
+(instancetype)sharedProvider;
+(NSArray *)_defaultFixedModuleIdentifiers;
+(id)_configurationFileURL;
+(id)_configurationDirectoryURL;
+(id)_readOrderedIdentifiers;
+(id)_defaultUserEnabledModuleIdentifiers;
+(void)_writeOrderedIdentifiers:(id)arg1 ;
+(id)_defaultEnabledModuleOrder;
-(void)_saveSettings;
-(void)_startMonitoringConfigurationUpdates;
-(void)_stopMonitoringConfigurationUpdates;
-(void)_handleConfigurationFileUpdate;
-(void)setAndSaveOrderedUserEnabledModuleIdentifiers:(id)arg1 ;
-(void)_loadSettings;
-(NSArray *)orderedFixedModuleIdentifiers;
-(NSArray *)orderedUserEnabledModuleIdentifiers;
@end
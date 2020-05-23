@interface FBSSystemService : NSObject
+ (instancetype)sharedService;
- (void)openApplication:(NSString *)bundleId options:(NSDictionary *)options withResult:(id)result;
@end
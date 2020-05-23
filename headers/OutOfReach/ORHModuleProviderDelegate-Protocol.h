#import <OutOfReach/ORHContentModule-Protocol.h>

@protocol ORHModuleProviderDelegate <NSObject>
@required
+ (NSArray<NSString *> *)possibleIdentifiers;
+ (id<ORHContentModule>)moduleForIdentifier:(NSString *)identifier;
+ (UIImage *)glyphForIdentifier:(NSString *)identifier;
+ (UIColor *)glyphBackgroundColorForIdentifier:(NSString *)identifier;
+ (NSString *)displayNameForIdentifier:(NSString *)identifier;

@optional
+ (BOOL)useFullIconImages;
// + (NSInteger)rowsForIdentifier:(NSString *)identifier;
// + (NSInteger)columnsForIdentifier:(NSString *)identifier;
@end
#import <ControlCenterUI/ControlCenterUI-Structs.h>

@interface CCUIControlCenterPositionProviderPackingRule : NSObject {

	NSUInteger _packFrom;
	NSUInteger _packingOrder;
	CCUILayoutSize _sizeLimit;

}

@property (nonatomic,readonly) NSUInteger packFrom;
@property (nonatomic,readonly) NSUInteger packingOrder;
@property (nonatomic,readonly) CCUILayoutSize sizeLimit;
-(id)initWithPackFrom:(NSUInteger)packFrom packingOrder:(NSUInteger)packingOrder sizeLimit:(CCUILayoutSize)sizeLimit;
-(NSUInteger)packFrom;
-(NSUInteger)packingOrder;
-(CCUILayoutSize)sizeLimit;
@end
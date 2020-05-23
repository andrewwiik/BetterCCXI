#import <ControlCenterUI/CCUIControlCenterPositionProviderPackingRule.h>
#import <ControlCenterUI/ControlCenterUI-Structs.h>

@interface BCMControlCenterPositionProvider : NSObject {

	NSArray<CCUIControlCenterPositionProviderPackingRule *>* _packingRules;
	NSDictionary* _rectByIdentifier;
	CCUILayoutSize _layoutSize;

}

@property (nonatomic,readonly) CCUILayoutSize layoutSize;
@property (nonatomic,readonly) CCUILayoutSize maximumLayoutSize; 
-(CCUILayoutSize)layoutSize;
-(id)initWithPackingRules:(NSArray<CCUIControlCenterPositionProviderPackingRule *> *)packingRules;
-(CCUILayoutSize)maximumLayoutSize;
-(void)regenerateRectsWithOrderedIdentifiers:(NSArray<NSString *> *)orderedIdentifiers orderedSizes:(NSArray<NSValue *> *)orderedSizes;
-(CCUILayoutRect)layoutRectForIdentifier:(NSString *)identifier;
@end
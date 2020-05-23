#import <ControlCenterUI/ControlCenterUI-Structs.h>
#import <ControlCenterUI/CCUIControlCenterPositionProviderPackingRule.h>

@interface CCUIControlCenterPositionProvider : NSObject {

	NSArray<CCUIControlCenterPositionProviderPackingRule *>* _packingRules;
	NSDictionary* _rectByIdentifier;
	CCUILayoutSize _layoutSize;

}

@property (nonatomic,readonly) CCUILayoutSize layoutSize;                     //@synthesize layoutSize=_layoutSize - In the implementation block
@property (nonatomic,readonly) CCUILayoutSize maximumLayoutSize; 
-(CCUILayoutSize)layoutSize;
-(id)_generateRectByIdentifierWithOrderedIdentifiers:(NSArray<NSString *> *)orderedIdentifiers orderedSizes:(NSArray<NSValue *> *)orderedSizes packingOrder:(NSUInteger)packingOrder startPosition:(CCUILayoutPoint)startPosition maximumSize:(CCUILayoutSize)arg5 outputLayoutSize:(out CCUILayoutSize*)ouputSize;
-(id)initWithPackingRules:(NSArray<CCUIControlCenterPositionProviderPackingRule *> *)packingRules;
-(CCUILayoutSize)maximumLayoutSize;
-(void)regenerateRectsWithOrderedIdentifiers:(NSArray<NSString *> *)orderedIdentifiers orderedSizes:(NSArray<NSValue *> *)orderedSizes;
-(CCUILayoutRect)layoutRectForIdentifier:(NSString *)identifier;
@end

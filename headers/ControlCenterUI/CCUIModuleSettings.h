#import "ControlCenterUI-Structs.h"

@interface CCUIModuleSettings : NSObject {

	CCUILayoutSize _portraitLayoutSize;
	CCUILayoutSize _landscapeLayoutSize;

}
-(BOOL)isEqual:(id)arg1 ;
-(CCUILayoutSize)layoutSizeForInterfaceOrientation:(NSInteger)orientation;
-(id)initWithPortraitLayoutSize:(CCUILayoutSize)portraitSize landscapeLayoutSize:(CCUILayoutSize)landscapeSize;
@end

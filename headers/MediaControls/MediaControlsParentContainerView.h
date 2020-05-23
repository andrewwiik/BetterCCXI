#import "MediaControlsContainerView.h"
@interface MediaControlsParentContainerView : UIView
@property (nonatomic,retain) MediaControlsContainerView *mediaControlsContainerView;
@property (nonatomic,retain) MediaControlsContainerView *containerView;
- (void)setStyle:(NSInteger)style;
@end
#import "MediaControlsHeaderView.h"
#import "MediaControlsParentContainerView.h"
#import "MediaControlsVolumeContainerView.h"
@interface MediaControlsPanelViewController : UIViewController
@property (nonatomic,retain) MediaControlsHeaderView *headerView;
@property (nonatomic,retain) MediaControlsParentContainerView *parentContainerView;
@property (nonatomic,retain) MediaControlsVolumeContainerView *volumeContainerView;
+(instancetype)panelViewControllerForCoverSheet;
@property (assign,nonatomic) NSInteger style;
-(void)willTransitionToSize:(CGSize)arg1 withCoordinator:(id)arg2;
-(void)setOnScreen:(BOOL)arg1;
- (void)_updateStyle;
@end
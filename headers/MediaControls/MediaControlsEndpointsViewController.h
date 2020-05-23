#import <MediaControls/MediaControlsCollectionViewController.h>
@interface MediaControlsEndpointsViewController : MediaControlsCollectionViewController
- (CGFloat)preferredExpandedContentHeight;
- (CGFloat)preferredExpandedContentWidth;
-(void)_adjustForEnvironmentChangeWithSize:(CGSize)size transitionCoordinator:(id)coordinator;
@end
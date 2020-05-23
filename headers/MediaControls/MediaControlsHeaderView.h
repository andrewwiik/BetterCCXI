#import <MPUFoundation/MPUMarqueeView.h>

@interface MediaControlsHeaderView : UIView
@property (nonatomic,retain) UIImageView *artworkView;
@property (nonatomic,retain) UIView *artworkBackground;
@property (nonatomic,retain) UIView *artworkBackgroundView;
@property (nonatomic,retain) UIImageView *placeholderArtworkView;
@property (nonatomic,retain) UIButton *launchNowPlayingAppButton;
@property (nonatomic,retain) MPUMarqueeView *titleMarqueeView;
@property (nonatomic,retain) MPUMarqueeView *primaryMarqueeView;
@property (nonatomic,retain) MPUMarqueeView *secondaryMarqueeView;
@property (nonatomic,retain) UILabel *primaryLabel;
@property (nonatomic,retain) UILabel *secondaryLabel;
@property (assign,nonatomic) BOOL shouldUsePlaceholderArtwork;
@property (nonatomic,retain) NSString *titleString;
@property (nonatomic,retain) NSString *primaryString;
@property (nonatomic,retain) NSString *secondaryString;
- (void)setStyle:(NSInteger)style;
- (id)routeLabel;
@end
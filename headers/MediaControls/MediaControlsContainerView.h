#import "MediaControlsTransportStackView.h"
#import "MediaControlsTimeControl.h"

@interface MediaControlsContainerView : UIView
@property (nonatomic,retain) MediaControlsTransportStackView *mediaControlsTransportStackView;
@property(retain, nonatomic) MediaControlsTransportStackView *transportStackView;
@property (nonatomic,retain) MediaControlsTimeControl *mediaControlsTimeControl;
@property(retain, nonatomic) MediaControlsTimeControl *timeControl;
@property (assign,nonatomic) NSInteger mediaControlsPlayerState;
@property (assign,nonatomic) NSInteger style;
@property (assign,getter=isTimeControlOnScreen,nonatomic) BOOL timeControlOnScreen; 
@property (nonatomic,retain) UIVisualEffectView *primaryVisualEffectView;
-(BOOL)isTimeControlOnScreen;
@end
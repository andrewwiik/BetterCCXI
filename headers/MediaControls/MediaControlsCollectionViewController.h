@interface MediaControlsCollectionViewController : UIViewController
@property (assign,nonatomic) BOOL displayMultipleDestinations;
@property (assign,nonatomic) NSInteger displayMode;
@property (nonatomic, retain) NSArray *visibleBottomViewControllers;
-(CGFloat)_heightForCompact;
- (void)viewWillTransitionToSize:(CGSize)size;
- (void)_updateContentInsets;
- (void)_updateContentSize;
@end
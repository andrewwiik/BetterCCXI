#import <MaterialKit/MTMaterialView.h>

@interface MTPlatterView : UIView {
	MTMaterialView* _mainOverlayView;
}

@property (nonatomic,readonly) MTMaterialView *backgroundMaterialView;
@property (assign,nonatomic) BOOL usesBackgroundView;
@property (nonatomic,retain) UIView *backgroundView;
@property (assign,getter=isBackgroundBlurred,nonatomic) BOOL backgroundBlurred; 
-(void)_configureBackgroundViewIfNecessary;
- (MTPlatterView *)initWithRecipe:(NSInteger)recipe options:(NSUInteger)options;

// For Notifications: recipe: 1 options: 2
@end
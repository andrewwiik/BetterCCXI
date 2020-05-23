@interface _MTBackdropView : UIView
@property (assign,nonatomic) CGFloat luminanceAlpha; 
@property (assign,nonatomic) CGFloat blurRadius; 
@property (assign,nonatomic) CGFloat saturation; 
@property (assign,nonatomic) CGFloat brightness; 
@property (assign,nonatomic) CGFloat zoom;                                                                                                //@synthesize zoom=_zoom - In the implementation block
@property (assign,nonatomic) CGFloat rasterizationScale;
@property (nonatomic, retain) UIColor *colorMatrixColor;
@end
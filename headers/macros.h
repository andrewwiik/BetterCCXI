#define NSCLeft        NSLayoutAttributeLeft
#define NSCRight       NSLayoutAttributeRight
#define NSCTop         NSLayoutAttributeTop
#define NSCBottom      NSLayoutAttributeBottom
#define NSCLeading     NSLayoutAttributeLeading
#define NSCTrailing    NSLayoutAttributeTrailing
#define NSCWidth       NSLayoutAttributeWidth
#define NSCHeight      NSLayoutAttributeHeight
#define NSCCenterX     NSLayoutAttributeCenterX
#define NSCCenterY     NSLayoutAttributeCenterY
#define NSCBaseline    NSLayoutAttributeBaseline

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define NSCLessThanOrEqual     NSLayoutRelationLessThanOrEqual
#define NSCEqual               NSLayoutRelationEqual
#define NSCGreaterThanOrEqual  NSLayoutRelationGreaterThanOrEqual

#define Constraint(item1, attr1, rel, item2, attr2, con) [NSLayoutConstraint constraintWithItem:(item1) attribute:(attr1) relatedBy:(rel) toItem:(item2) attribute:(attr2) multiplier:1 constant:(con)]
#define VisualConstraints(format, ...) [NSLayoutConstraint constraintsWithVisualFormat:(format) options:0 metrics:nil views:_NSDictionaryOfVariableBindings(@"" # __VA_ARGS__, __VA_ARGS__, nil)]
#define VisualConstraintWithMetrics(format, theMetrics, ...) [NSLayoutConstraint constraintsWithVisualFormat:(format) options:0 metrics:(theMetrics) views:_NSDictionaryOfVariableBindings(@"" # __VA_ARGS__, __VA_ARGS__, nil)]
#define ConstantConstraint(item, attr, rel, con) Constraint((item), (attr), (rel), nil, NSLayoutAttributeNotAnAttribute, (con))

#define horizontallyFillSuperview ^(UIView *view, NSUInteger idx, BOOL *stop) {[view.superview addConstraints:VisualConstraints(@"|[view]|", view)];}


// #define IS_RTL ([MZELayoutOptions isRTL])
#if __cplusplus
    extern "C" {
#endif
  CGPoint UIRectGetCenter(CGRect rect);
	CGFloat UICeilToViewScale(CGFloat value, UIView *view);
	CGFloat UIRoundToViewScale(CGFloat value, UIView *view);
  CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);
	//CGPoint UIPointRoundToViewScale(CGPoint point, UIView *view);
#if __cplusplus
}
#endif

// #ifdef __cplusplus
// extern "C" {
// #endif

// CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

// #ifdef __cplusplus
// }
// #endif

#define UIPointRoundToViewScale(point, view) CGPointMake(UIRoundToViewScale(point.x, view), UIRoundToViewScale(point.y,view))

//#define UIColorFromRGB(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];


static inline unsigned int intFromHexString(NSString *hexString) {
	unsigned int hexInt = 0;

  // Create scanner
  NSScanner *scanner = [NSScanner scannerWithString:hexString];

  // Tell scanner to skip the # character
  [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];

  // Scan hex value
  [scanner scanHexInt:&hexInt];

  return hexInt;
}

static inline UIColor *colorFromHexString(NSString *hexString) {
	unsigned int hexint = intFromHexString(hexString);

  // Create color object, specifying alpha as well
  UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
    blue:((CGFloat) (hexint & 0xFF))/255
    alpha:1.0];

  return color;
}
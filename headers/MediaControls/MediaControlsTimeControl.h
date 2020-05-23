@interface MediaControlsTimeControl : UIControl {
	NSArray* _defaultConstraints;
	NSArray* _trackingConstraints;
	NSArray* _initialConstraints;
}
@property (assign,nonatomic) NSInteger style;
@property (assign,getter=isEmpty,nonatomic) BOOL empty;
@property (assign,getter=isTimeControlOnScreen,nonatomic) BOOL timeControlOnScreen;
-(BOOL)isCurrentlyTracking;
-(BOOL)isTimeControlOnScreen;
-(BOOL)isEmpty;
-(void)updateLabelAvoidance;
- (void)cancelTrackingWithEvent:(id)event;
@end
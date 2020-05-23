@interface MPMediaControlsConfiguration : NSObject {
	NSInteger _style;
	NSString* _routingContextUID;
	NSString* _presentingAppBundleID;
}

@property (assign,nonatomic) NSInteger style;
@property (nonatomic,copy) NSString *routingContextUID;
@property (nonatomic,copy) NSString *presentingAppBundleID;
-(NSInteger)style;
-(void)setStyle:(NSInteger)style;
-(NSString *)routingContextUID;
-(void)setRoutingContextUID:(NSString *)contextUID;
-(NSString *)presentingAppBundleID;
-(void)setPresentingAppBundleID:(NSString *)bundleId;
@end
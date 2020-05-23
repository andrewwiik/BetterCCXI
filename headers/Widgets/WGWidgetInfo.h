@interface NSExtension : NSObject
- (NSString *)nc_extensionContainerBundleIdentifier;
@end

@interface WGWidgetInfo : NSObject
@property (nonatomic,copy,readonly) NSString *widgetIdentifier; 
@property (nonatomic,readonly) UIImage *settingsIcon; 
@property (nonatomic,readonly) CGFloat initialHeight; 
@property (assign,nonatomic) CGSize preferredContentSize;                                                            //@synthesize preferredContentSize=_preferredContentSize - In the implementation block
@property (setter=_setDisplayName:,nonatomic,copy) NSString *displayName;                                           //@synthesize displayName=_displayName - In the implementation block
@property (setter=_setIcon:,nonatomic,retain) UIImage *icon;                                                        //@synthesize icon=_icon - In the implementation block
@property (setter=_setOutlineIcon:,nonatomic,retain) UIImage *outlineIcon;
@property (nonatomic, retain) NSExtension *extension;  
@end
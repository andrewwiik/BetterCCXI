@interface LAContext : NSObject {

	BOOL _cancelButtonVisible;
	BOOL _fallbackButtonVisible;
	NSString* _localizedFallbackTitle;
	NSString* _creatorDisplayName;
	NSData* _externalizedContext;

}

@property (nonatomic,copy) NSString * localizedFallbackTitle;                                        //@synthesize localizedFallbackTitle=_localizedFallbackTitle - In the implementation block
@property (retain) NSString * creatorDisplayName;                                                    //@synthesize creatorDisplayName=_creatorDisplayName - In the implementation block
@property (retain) NSData * externalizedContext;                                                     //@synthesize externalizedContext=_externalizedContext - In the implementation block
@property (assign,getter=isCancelButtonVisible,nonatomic) BOOL cancelButtonVisible;                  //@synthesize cancelButtonVisible=_cancelButtonVisible - In the implementation block
@property (assign,getter=isFallbackButtonVisible,nonatomic) BOOL fallbackButtonVisible;              //@synthesize fallbackButtonVisible=_fallbackButtonVisible - In the implementation block
-(NSString *)creatorDisplayName;
-(NSData *)externalizedContext;
-(id)initWithExternalizedContext:(id)arg1 uiDelegate:(id)arg2 ;
-(void)setCreatorDisplayName:(NSString *)arg1 ;
-(void)setExternalizedContext:(NSData *)arg1 ;
-(void)setCancelButtonVisible:(BOOL)arg1 ;
-(void)setFallbackButtonVisible:(BOOL)arg1 ;
-(BOOL)isCancelButtonVisible;
-(BOOL)isFallbackButtonVisible;
-(NSString *)localizedFallbackTitle;
-(id)evaluatePolicy:(long long)arg1 options:(id)arg2 error:(id*)arg3 ;
-(id)initWithExternalizedContext:(id)arg1 ;
-(id)initWithUIDelegate:(id)arg1 ;
-(void)evaluatePolicy:(long long)arg1 localizedReason:(id)arg2 reply:(/*^block*/id)arg3 ;
-(BOOL)canEvaluatePolicy:(long long)arg1 error:(id*)arg2 ;
-(void)setLocalizedFallbackTitle:(NSString *)arg1 ;
-(void)evaluatePolicy:(long long)arg1 options:(id)arg2 reply:(/*^block*/id)arg3 ;
-(void)failProcessedEvent:(long long)arg1 failureError:(id)arg2 reply:(/*^block*/id)arg3 ;
-(void)enterPassword:(id)arg1 reply:(/*^block*/id)arg2 ;
-(id)init;
-(void)invalidate;
@end
@interface WGWidgetListItemViewController : UIViewController
-(void)viewWillTransitionToSize:(CGSize)arg1 withTransitionCoordinator:(id)arg2 ;
-(CGSize)_pendingSize;
-(void)_setPendingSize:(CGSize)arg1 ;
-(void)_addWidgetHostIfNecessary;
-(void)managingContainerWillAppear:(id)arg1 ;
-(void)managingContainerDidDisappear:(id)arg1 ;
@end
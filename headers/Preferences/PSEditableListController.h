#import <Preferences/PSListController.h>

@interface PSEditableListController : PSListController {

	BOOL _editable;
	BOOL _editingDisabled;

}
-(id)init;
-(id)tableView:(id)arg1 willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCellEditingStyle)tableView:(id)arg1 editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(id)arg1 commitEditingStyle:(NSInteger)arg2 forRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)suspend;
-(void)viewWillAppear:(BOOL)arg1 ;
-(void)setEditable:(BOOL)arg1 ;
-(BOOL)editable;
-(void)editDoneTapped;
-(id)_editButtonBarItem;
-(void)_setEditable:(BOOL)arg1 animated:(BOOL)arg2 ;
-(BOOL)performDeletionActionForSpecifier:(id)arg1 ;
-(void)setEditingButtonHidden:(BOOL)arg1 animated:(BOOL)arg2 ;
-(void)setEditButtonEnabled:(BOOL)arg1 ;
-(void)didLock;
-(void)showController:(id)arg1 animate:(BOOL)arg2 ;
-(void)_updateNavigationBar;
@end
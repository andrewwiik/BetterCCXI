#import <ControlCenterUI/CCUIModuleSettingsManager.h>
#import <ControlCenterUI/ControlCenterUI-Structs.h>
#import <ControlCenterUI/CCUIModuleSettings.h>
#import <ControlCenterServices/CCSModuleSettingsProvider.h>
#import <MediaPlayer/MPMediaControlsConfiguration.h>
#import <MediaControls/MediaControlsCollectionViewController.h>
#import <MediaControls/MRPlatterViewController.h>
#import <MediaControls/MediaControlsEndpointsViewController.h>
#import <MediaControls/MediaControlsTimeControl.h>
#import <MediaControls/MediaControlsHeaderView.h>
#import <UIKit/UIView+Private2.h>
#import <MaterialKit/_MTBackdropView.h>
#import <macros.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
// #import "fishhook.h"

//static CGFloat changedWidth = 238;
CGFloat cachedExpandedHeight = 0;

static NSMutableDictionary *globalSettings;
static NSInteger connectModSizeOption = 1;
static NSInteger musicModSizeOption = 1;
static NSInteger weatherModSizeOption = 1;
static NSInteger compactStyleOpt = 3;
static NSInteger compactDisabledOpt = 6;
static BOOL useArtworkBG = YES;

#if __cplusplus
    extern "C" {
#endif
  extern CGFloat MediaControlsMaxWidthOfCondensedModule;
	//CGPoint UIPointRoundToViewScale(CGPoint point, UIView *view);
#if __cplusplus
}
#endif

struct CCUILayoutSize CCUILayoutSizeMake2(NSUInteger width, NSUInteger height) {
    CCUILayoutSize layoutSize;
    layoutSize.width = width;
    layoutSize.height = height;
    return layoutSize;
}

@interface MSHJelloView : UIView{
    NSUInteger cachedLength;
    int connfd;
    float *empty;
}

@property (nonatomic, assign) BOOL ignoreDisconnect;

-(void)reloadConfig;
-(void)msdConnect;
-(void)msdDisconnect;

-(void)initializeWaveLayers;
-(void)resetWaveLayers;
-(void)redraw;
@end

@interface MRPlatterViewController (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@property (nonatomic, assign) CGFloat cachedExpandedHeight;
- (MediaControlsTimeControl *)bcm_timeControl;
- (MSHJelloView *)mitsuhaJelloView;
@end

@interface MediaControlsHeaderView (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@property (nonatomic, retain) _MTBackdropView *artworkOverlayView;
- (void)bcm_fixTextLayout;
- (MediaControlsTimeControl *)bcm_timeControl;
- (UIVisualEffectView *)bcm_timeControlEffectView;
@end

@interface MediaControlsParentContainerView (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@end

@interface MediaControlsContainerView (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@end

@interface MediaControlsTransportStackView (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@end

@interface MediaControlsVolumeContainerView (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@end

@interface MediaControlsTimeControl (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@property (nonatomic, retain) NSArray *savedTrackingConstraints;
@property (nonatomic, assign) BOOL bcm_ignoreTimeFrameSet;
@end

@interface UIVisualEffectView (ORHMusicModule)
@property (nonatomic, assign) BOOL isBCMMusicModule;
@property (nonatomic, assign) BOOL bcm_ignoreTimeFrameSet;
@end

@interface UIView (ORHPrivate)
@property (nonatomic, assign) BOOL bcm_forceCornerRadius;
@property (nonatomic, assign) CGFloat bcm_forcedCornerRadius;
@end

%hook UIView
%property (nonatomic, assign) BOOL bcm_forceCornerRadius;
%property (nonatomic, assign) CGFloat bcm_forcedCornerRadius;

- (void)_setContinuousCornerRadius:(CGFloat)cornerRadius {
	if (self.bcm_forceCornerRadius) return %orig(self.bcm_forcedCornerRadius);
	return %orig;
}

- (void)_setCornerRadius:(CGFloat)cornerRadius {
	if (self.bcm_forceCornerRadius) return %orig(self.bcm_forcedCornerRadius);
	return %orig;
}

- (CGFloat)_continuousCornerRadius {
	if (self.bcm_forceCornerRadius) return self.bcm_forcedCornerRadius;
	return %orig;
}

- (CGFloat)_cornerRadius {
	if (self.bcm_forceCornerRadius) return self.bcm_forcedCornerRadius;
	return %orig;
}
%end

@interface CALayer (ORHPrivate)
@property (nonatomic, assign) BOOL bcm_forceCornerRadius;
@property (nonatomic, assign) CGFloat bcm_forcedCornerRadius;
@end

%hook CALayer
%property (nonatomic, assign) BOOL bcm_forceCornerRadius;
%property (nonatomic, assign) CGFloat bcm_forcedCornerRadius;

- (void)setCornerRadius:(CGFloat)cornerRadius {
	if (self.bcm_forceCornerRadius) return %orig(self.bcm_forcedCornerRadius);
	return %orig;
}


- (CGFloat)cornerRadius {
	if (self.bcm_forceCornerRadius) return self.bcm_forcedCornerRadius;
	return %orig;
}
%end

// static NSInteger fakeStyle = 0;

static BOOL shouldFakeStyle = YES;
static CGFloat inset = 0;

// static CGRect timeControlFrame = CGRectZero;

%hook MRPlatterViewController
%property (nonatomic, assign) BOOL isBCMMusicModule;
%property (nonatomic, assign) CGFloat cachedExpandedHeight;

%new
- (id)headerView {
	return self.nowPlayingHeaderView;
}

%new
- (MediaControlsTimeControl *)bcm_timeControl {
	if (self.isBCMMusicModule) {
		MediaControlsParentContainerView *parentContainerView = self.parentContainerView;
		if (parentContainerView) {
			MediaControlsContainerView *containerView = parentContainerView.mediaControlsContainerView;
			if (containerView) {
				return containerView.mediaControlsTimeControl;
			}
		}
	}
	return nil;
}

%new
- (BOOL)bcm_isFakingStyle {
	return shouldFakeStyle;
}

-(void)_updateOnScreenForStyle:(NSInteger)style {
	if (self.isBCMMusicModule && shouldFakeStyle) {
		style = 3;
	}
	%orig(style);

	// if (self.isBCMMusicModule) {
	// 	if ([self respondsToSelector:@selector(mitsuhaJelloView)]) {
	// 		MSHJelloView *jelloView = [self mitsuhaJelloView];
	// 		if (jelloView) {
	// 			//jelloView.ignoreDisconnect = YES;
	// 			int connfd = MSHookIvar<int>(jelloView, "connfd");
	// 			if (connfd < 0) {
	// 				[jelloView msdConnect];
	// 			}
	// 		}
	// 	}
	// }
}

- (void)_updateSecondaryStringFormat {

	if (self.isBCMMusicModule && shouldFakeStyle) {
		MSHookIvar<NSInteger>(self,"_style") = 2;
	}
	%orig;
	// if (self.isBCMMusicModule && shouldFakeStyle) {
	// 	MSHookIvar<NSInteger>(self,"_style") = 0;
	// }
}

-(void)_updateStyle {
	if (self.isBCMMusicModule) {
		self.headerView.isBCMMusicModule = self.isBCMMusicModule;
		self.parentContainerView.isBCMMusicModule = self.isBCMMusicModule;

		// if ([self respondsToSelector:@selector(mitsuhaJelloView)]) {
		// 	MSHJelloView *jelloView = [self mitsuhaJelloView];
		// 	if (jelloView) {
		// 		//jelloView.ignoreDisconnect = YES;
		// 		int connfd = MSHookIvar<int>(jelloView, "connfd");
		// 		if (connfd < 0) {
		// 			[jelloView msdConnect];
		// 		}
		// 	}
		// }
	}

	// if ([self respondsToSelector:@selector(mitsuhaJelloView)]) {
	// 	MSHJelloView *jelloView = [self mitsuhaJelloView];
	// 	if (jelloView) {
	// 		//jelloView.ignoreDisconnect = YES;
	// 		int connfd = MSHookIvar<int>(jelloView, "connfd");
	// 		if (connfd > 0) {
	// 			[jelloView msdDisconnect];
	// 		}
	// 		[jelloView reloadConfig];
	// 		[jelloView msdConnect];
	// 	}
	// }
	%orig;
}

-(void)willTransitionToSize:(CGSize)size withCoordinator:(id)arg2 {
	// if (self.isBCMMusicModule) {
	// 	if (size.height <= cachedExpandedHeight) {
	// 		shouldFakeStyle = YES;
	// 	} else {
	// 		shouldFakeStyle = NO;
	// 	}
	// }
	%orig;
	// if ([self respondsToSelector:@selector(mitsuhaJelloView)] && self.isBCMMusicModule) {
	// 	MSHJelloView *jelloView = [self mitsuhaJelloView];
	// 	if (jelloView) {
	// 		//jelloView.ignoreDisconnect = YES;
	// 		int connfd = MSHookIvar<int>(jelloView, "connfd");
	// 		if (connfd == -2) {
	// 			[jelloView reloadConfig];
	// 			[jelloView msdConnect];
	// 		}
	// 	}
	// }
}

- (void)viewWillAppear:(BOOL)animated {
	%orig;

	if (self.isBCMMusicModule) {

		// if ([self respondsToSelector:@selector(mitsuhaJelloView)]) {
		// 	MSHJelloView *jelloView = [self mitsuhaJelloView];
		// 	if (jelloView) {
		// 		jelloView.ignoreDisconnect = YES;
		// 		int connfd = MSHookIvar<int>(jelloView, "connfd");
		// 		if (connfd < 1) {
		// 			[jelloView reloadConfig];
		// 			[jelloView msdConnect];
		// 		}
		// 	}
		// }
	}
}

-(void)viewDidLayoutSubviews {
	%orig;


	if (self.isBCMMusicModule && shouldFakeStyle) {

		if ([self respondsToSelector:@selector(mdartsyAlbum)]) {
			self.view.bcm_forceCornerRadius = YES;
			self.view.bcm_forcedCornerRadius  = 19.0;
			self.view._continuousCornerRadius = 19.0;
			self.view.layer.bcm_forceCornerRadius = YES;
			self.view.layer.bcm_forcedCornerRadius = 19.0;
		}
		inset = self.headerView.artworkView.frame.origin.x;
		CGFloat artworkHeight = self.headerView.artworkBackgroundView.frame.size.height;
		if (musicModSizeOption == compactStyleOpt) {
			self.headerView.frame = CGRectMake(0,30,self.view.bounds.size.width, artworkHeight + 15);
			if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) {
				if (useArtworkBG) {
					[[self.headerView superview] sendSubviewToBack:self.headerView];
				}
			} else {
				if (useArtworkBG) {
					[self.view bringSubviewToFront:self.parentContainerView];
				}
			}
			//[self.view sendSubviewToBack:self.headerView];
		} else {
			self.headerView.frame = CGRectMake(-7,15,self.view.bounds.size.width + 7, artworkHeight);
		}
		self.parentContainerView.frame = CGRectMake(0, self.headerView.frame.size.height + self.headerView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - (self.headerView.frame.size.height + self.headerView.frame.origin.y));
		// self.volumeContainerView.frame = CGRectMake(inset, self.parentContainerView.frame.origin.y + self.parentContainerView.frame.size.height, self.view.bounds.size.width - (inset * 2), self.view.bounds.size.height - (self.parentContainerView.frame.origin.y + self.parentContainerView.frame.size.height));
		// self.volumeContainerView.alpha = 1.0;
		// self.volumeContainerView.hidden = NO;

		// if ([self respondsToSelector:@selector(mitsuhaJelloView)]) {
		// 	MSHJelloView *jelloView = [self mitsuhaJelloView];
		// 	if (jelloView) {
		// 		[[self.parentContainerView superview] insertSubview:jelloView belowSubview:self.parentContainerView];
		// 		//[self.view insertSubview:jelloView belowSubview:[self.parentContainerView superview]];
		// 		// [self.view artr:jelloView];
		// 		// [self.view bringSubviewToFront:self.parentContainerView];
		// 	}
		// }

	} else if (self.isBCMMusicModule) {
		self.view.bcm_forceCornerRadius = NO;
		self.view.layer.bcm_forceCornerRadius = NO;
	}

	if (self.isBCMMusicModule) {
		if ([self respondsToSelector:@selector(mitsuhaJelloView)]) {
			MSHJelloView *jelloView = [self mitsuhaJelloView];
			if (jelloView) {
				int connfd = MSHookIvar<int>(jelloView, "connfd");
				if (connfd == -2) {
					[jelloView reloadConfig];
					[jelloView msdConnect];
				}
			}
		}
	}
}

-(void)viewWillLayoutSubviews {
	%orig;


	if (self.isBCMMusicModule && shouldFakeStyle) {
		if ([self respondsToSelector:@selector(mdartsyAlbum)]) {
			self.view.bcm_forceCornerRadius = YES;
			self.view.bcm_forcedCornerRadius  = 19.0;
			self.view._continuousCornerRadius = 19.0;
			self.view.layer.bcm_forceCornerRadius = YES;
			self.view.layer.bcm_forcedCornerRadius = 19.0;
		}
		inset = self.headerView.artworkView.frame.origin.x;
		CGFloat artworkHeight = self.headerView.artworkBackgroundView.frame.size.height;
		if (musicModSizeOption == compactStyleOpt) {
			self.headerView.frame = CGRectMake(0,30,self.view.bounds.size.width, artworkHeight + 15);
			if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) {
				[[self.headerView superview] sendSubviewToBack:self.headerView];
			} else {
				[self.view bringSubviewToFront:self.parentContainerView];
			}
			//[self.view bringSubviewToFront:self.parentContainerView];
			//[self.view sendSubviewToBack:self.headerView];
		} else {
			self.parentContainerView.hidden = FALSE;
			self.headerView.frame = CGRectMake(-7,15,self.view.bounds.size.width + 7, artworkHeight);
		}
		self.parentContainerView.frame = CGRectMake(0, self.headerView.frame.size.height + self.headerView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - (self.headerView.frame.size.height + self.headerView.frame.origin.y));
		// self.volumeContainerView.frame = CGRectMake(inset, self.parentContainerView.frame.origin.y + self.parentContainerView.frame.size.height, self.view.bounds.size.width - (inset * 2), self.view.bounds.size.height - (self.parentContainerView.frame.origin.y + self.parentContainerView.frame.size.height));
		// self.volumeContainerView.alpha = 1.0;
		// self.volumeContainerView.hidden = NO;

	} else if (self.isBCMMusicModule) {
		self.view.bcm_forceCornerRadius = NO;
		self.view.layer.bcm_forceCornerRadius = NO;
	}

	if (self.isBCMMusicModule) {
		// if ([self respondsToSelector:@selector(mitsuhaJelloView)]) {
		// 	MSHJelloView *jelloView = [self mitsuhaJelloView];
		// 	if (jelloView) {
		// 		int connfd = MSHookIvar<int>(jelloView, "connfd");
		// 		if (connfd > 0) {
		// 			[jelloView msdDisconnect];
		// 		}
		// 		[jelloView reloadConfig];
		// 		[jelloView msdConnect];
		// 	}
		// }
	}
}

- (void)setStyle:(NSInteger)style {
	if (self.isBCMMusicModule && shouldFakeStyle) {
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) %orig(1);
		else %orig(0);
		// %orig(0);
	} else {

		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) {
			if (self.view && [self.view superview]) {
				if ([[self.view superview] isKindOfClass:NSClassFromString(@"SBDashBoardMediaControlsView")]) {
					style = 3;
				}
			}
		}
		%orig(style);
	}
}

// -(void)viewDidDisappear:(BOOL)animated{
// 	return;
//     // %orig;
//     // [self.mitsuhaJelloView msdDisconnect];
// }
%end

%hook MediaControlsVolumeContainerView
%property (nonatomic, assign) BOOL isBCMMusicModule;
%end

static BOOL fakeArtworkSize = NO;

%hook MediaControlsHeaderView
%property (nonatomic, assign) BOOL isBCMMusicModule;
%property (nonatomic, retain) _MTBackdropView *artworkOverlayView;


%new
- (MediaControlsTimeControl *)bcm_timeControl {
	if (self.isBCMMusicModule) {
		UIViewController *parentController = [self _viewControllerForAncestor];
		if (parentController && [parentController isKindOfClass:NSClassFromString(@"MRPlatterViewController")]) {
			MRPlatterViewController *panelController = (MRPlatterViewController *)parentController;
			return [panelController bcm_timeControl];
		}
	}
	return nil;
}

%new
- (UIVisualEffectView *)bcm_timeControlEffectView {
	if (self.isBCMMusicModule) {
		UIViewController *parentController = [self _viewControllerForAncestor];
		if (parentController && [parentController isKindOfClass:NSClassFromString(@"MRPlatterViewController")]) {
			MRPlatterViewController *panelController = (MRPlatterViewController *)parentController;
			MediaControlsParentContainerView *parentContainerView = panelController.parentContainerView;
			if (parentContainerView) {
				MediaControlsContainerView *containerView = parentContainerView.mediaControlsContainerView;
				if (containerView) {
					return containerView.primaryVisualEffectView;
				}
			}
		}
	}
	return nil;
}


-(void)setArtworkCatalog:(id)arg2 {
	if (self.isBCMMusicModule) fakeArtworkSize = YES;
	%orig;
	if (self.isBCMMusicModule) fakeArtworkSize = NO;

}

- (CGSize)artworkSize {
	if (fakeArtworkSize) return CGSizeMake(500,500);
	return %orig;
}

- (void)setStyle:(NSInteger)style {
	if (self.isBCMMusicModule && shouldFakeStyle) {
		// if (sharedEffectView) {
		// 	if ([sharedEffectView superview] != self) {
		// 		[self addSubview:sharedEffectView];
		// 	}
		// }
		if (musicModSizeOption == compactStyleOpt) {
			if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) {
				%orig(0);
			} else {
				%orig(1);
			}
		} else {
			if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) {
				%orig(1);
			} else {
				%orig(2);
			}
		}
	} else {
		if (self.isBCMMusicModule && shouldFakeStyle == NO && SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) {
			%orig(0);
		} else %orig;
	}
}

- (void)setSecondaryString:(NSString *)string {
	if (self.isBCMMusicModule && shouldFakeStyle) {

		MRPlatterViewController *sharedController = (MRPlatterViewController *)[self _viewControllerForAncestor];
		if (sharedController && [sharedController isKindOfClass:NSClassFromString(@"MRPlatterViewController")]) {
			if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2")) {
				MSHookIvar<NSInteger>(sharedController,"_style") = 0;
			} else {
				MSHookIvar<NSInteger>(sharedController,"_style") = 1;
			}
		}
	}
	%orig;
}

%new
- (void)bcm_fixTextLayout {
	CGRect titleFrame = CGRectZero;
	if ([self respondsToSelector:@selector(titleMarqueeView)]) {
		titleFrame = self.titleMarqueeView.frame;
	} else {
		titleFrame = self.primaryMarqueeView.frame;
	}
	CGRect primaryFrame = self.primaryMarqueeView.frame;
	CGRect secondaryFrame = self.secondaryMarqueeView.frame;
	primaryFrame.origin = titleFrame.origin;
	if (musicModSizeOption != compactStyleOpt) {
		primaryFrame.origin.y = self.artworkView.frame.origin.y;
	}
	secondaryFrame.origin.y = titleFrame.origin.y + primaryFrame.size.height - 4;
	if (musicModSizeOption == compactStyleOpt) {
		primaryFrame.origin.x = 13;
		// primaryFrame.origin.y = 0;
		secondaryFrame.origin.x = 13;
	}
	self.primaryMarqueeView.frame = primaryFrame;
	self.secondaryMarqueeView.frame = secondaryFrame;
}

- (void)layoutSubviews {
	if (self.isBCMMusicModule && !self.artworkOverlayView) {
		self.artworkOverlayView = [[NSClassFromString(@"_MTBackdropView") alloc] initWithFrame:self.bounds];
		self.artworkOverlayView.luminanceAlpha = 0.6;
		self.artworkOverlayView.colorMatrixColor = [UIColor colorWithWhite: 0 alpha:0.4];
		self.artworkOverlayView.saturation = 2.5;
		self.artworkOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
		//self.artworkOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.72];
		self.artworkOverlayView.frame = self.artworkView.frame;
		[self addSubview:self.artworkOverlayView];
		self.artworkOverlayView.alpha = 0.0;

	}
	%orig;
	if (self.isBCMMusicModule && self.artworkOverlayView) {
		if (!shouldFakeStyle) {
			self.artworkOverlayView.alpha = 0.0;
		}
	}
	if (self.isBCMMusicModule && shouldFakeStyle) {
		if ([self respondsToSelector:@selector(titleMarqueeView)]) {
			self.titleMarqueeView.alpha = 0.0;
		}

		UIVisualEffectView *sharedEffectView = [self bcm_timeControlEffectView];
		MediaControlsTimeControl *sharedTimeControl = [self bcm_timeControl];
		if (sharedEffectView) {
			if ([sharedEffectView superview] != self) {
				[self addSubview:sharedEffectView];
			}
		}
		if (self.launchNowPlayingAppButton) {
			CGRect frame = CGRectMake(0,0,self.artworkView.bounds.size.height * 1.1,self.artworkView.bounds.size.height * 1.1);
			self.launchNowPlayingAppButton.frame = frame;
			self.launchNowPlayingAppButton.center = self.artworkView.center;
		}

		if (sharedEffectView) {
			UIView *viewToUse = self.primaryMarqueeView;
			if (self.secondaryString && [self.secondaryString length] > 0) viewToUse = self.secondaryMarqueeView;
			CGFloat xOrigin = self.primaryMarqueeView.frame.origin.x;
			CGFloat width = self.frame.size.width - (15 + self.primaryMarqueeView.frame.origin.x);
			if (musicModSizeOption == compactStyleOpt) {
				xOrigin = 13;
				width = self.bounds.size.width - (xOrigin * 2);
			}
			sharedEffectView.frame = CGRectMake(xOrigin, viewToUse.frame.origin.y + viewToUse.frame.size.height, width, 34);
			sharedEffectView.alpha = 1.0;

		}
		if (sharedTimeControl) {
			if (!sharedTimeControl.timeControlOnScreen) sharedTimeControl.timeControlOnScreen = YES;
			CGRect timeControlFrame = sharedEffectView.bounds;
			timeControlFrame.origin.y = -20;
			timeControlFrame.size.height = 54;
			sharedTimeControl.frame = timeControlFrame;
			sharedTimeControl.alpha = 1.0;
		}
		if (musicModSizeOption == compactStyleOpt && [self superview] && useArtworkBG) {
			if (self.artworkOverlayView) {
				[self sendSubviewToBack:self.artworkOverlayView];
			}
			[self sendSubviewToBack:self.artworkView];
			CGRect bounds = [self superview].bounds;
			CGRect frame = [self convertRect:bounds fromView:[self superview]];
			self.artworkView.frame = frame;
			self.artworkOverlayView.frame = self.artworkView.frame;
			[self.artworkOverlayView _setContinuousCornerRadius:19.0];

			if (!(self.artworkView.image == nil)) {
				self.artworkView.alpha = 1.0;
				self.artworkOverlayView.alpha = self.artworkView.alpha;
				self.primaryLabel.alpha = 1.0;
				self.secondaryLabel.alpha = 1.0;
				self.artworkView.hidden = NO;
			}
		}

		if (musicModSizeOption == compactStyleOpt && !useArtworkBG) {
			self.artworkView.alpha = 0.0;
			self.placeholderArtworkView.alpha = 0.0;
		}
		// self.titleMarqueeView.alpha = 0.0;
		// CGRect titleFrame = self.titleMarqueeView.frame;
		// CGRect primaryFrame = self.primaryMarqueeView.frame;
		// CGRect secondaryFrame = self.secondaryMarqueeView.frame;
		// primaryFrame.origin = titleFrame.origin;
		// primaryFrame.origin.y = self.artworkView.frame.origin.y;
		// secondaryFrame.origin.y = titleFrame.origin.y + primaryFrame.size.height;
		// self.primaryMarqueeView.frame = primaryFrame;
		// self.secondaryMarqueeView.frame = secondaryFrame;

	} else if (self.isBCMMusicModule) {
		self.artworkView._continuousCornerRadius = self.artworkBackgroundView._continuousCornerRadius;
	}
}

// %new
// - (BOOL)shouldUsePlaceholderArtwork {
// 	if (self.isBCMMusicModule) {
// 		if (sharedController) {
// 			id = MSH
// 		}
// 	}
// }

- (void)_updateStyle {
	%orig;

	if (self.isBCMMusicModule && !self.artworkOverlayView) {
		self.artworkOverlayView = [[NSClassFromString(@"_MTBackdropView") alloc] initWithFrame:self.bounds];
		self.artworkOverlayView.luminanceAlpha = 0.6;
		self.artworkOverlayView.colorMatrixColor = [UIColor colorWithWhite: 0 alpha:0.7];
		self.artworkOverlayView.saturation = 2.5;
		self.artworkOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
		self.artworkOverlayView.frame = self.artworkView.frame;
		[self addSubview:self.artworkOverlayView];
		self.artworkOverlayView.alpha = 0.0;

	}

	if (self.isBCMMusicModule && shouldFakeStyle) {
		if ([self respondsToSelector:@selector(titleMarqueeView)]) {
			self.titleMarqueeView.hidden = YES;
		}
	} else if (self.isBCMMusicModule) {
		if ([self respondsToSelector:@selector(titleMarqueeView)]) {
			self.titleMarqueeView.hidden = NO;
		}
	}
	if (self.isBCMMusicModule && shouldFakeStyle) {

		// UIVisualEffectView *sharedEffectView = [self bcm_timeControlEffectView];
		if ([self respondsToSelector:@selector(titleMarqueeView)]) {
			self.titleMarqueeView.alpha = 0.0;
		}
		self.secondaryMarqueeView.alpha = 0.75;
		self.secondaryMarqueeView.transform = CGAffineTransformMakeScale(0.8,0.8);
		self.secondaryMarqueeView.layer.anchorPoint = CGPointMake(0,0);
		[self.artworkView _setContinuousCornerRadius:6.0];
		[self.artworkBackgroundView _setContinuousCornerRadius: 6.0];
		if (musicModSizeOption == compactStyleOpt && useArtworkBG) {
			if (!(self.artworkView.image == nil)) {
				self.artworkView.alpha = 1.0;
				self.artworkView.hidden = NO;
			} else {
				self.artworkView.alpha = 0.0;
			}
			// self.placeholderArtworkView.alpha = 0.0;
			// self.artworkBackgroundView.alpha = 0.0;
		}
		if ((self.artworkView.image == nil)) {
			self.placeholderArtworkView.alpha = 1.0;
		} else {
			self.placeholderArtworkView.alpha = 0.0;
		}
		if (musicModSizeOption == compactStyleOpt && useArtworkBG) {
			self.artworkView.alpha = (self.artworkView.image == nil);
			self.placeholderArtworkView.alpha = 0.0;
			self.artworkBackgroundView.alpha = 0.0;
			[self.artworkView _setContinuousCornerRadius:19.0];

			if (self.artworkOverlayView) {
				[self sendSubviewToBack:self.artworkOverlayView];
			}
			[self sendSubviewToBack:self.artworkView];
			CGRect bounds = [self superview].bounds;
			CGRect frame = [self convertRect:bounds fromView:[self superview]];
			self.artworkView.frame = frame;
			self.artworkOverlayView.frame = self.artworkView.frame;

			if (!(self.artworkView.image == nil)) {
				self.artworkView.alpha = 1.0;
				self.artworkOverlayView.alpha = self.artworkView.alpha;
				self.artworkView.hidden = NO;
				self.primaryLabel.alpha = 1.0;
				self.secondaryLabel.alpha = 1.0;
				self.secondaryMarqueeView.alpha = 0.8;
				self.secondaryLabel.layer.filters = nil;
			}
			[self.artworkOverlayView _setContinuousCornerRadius:19.0];

		}

		if (musicModSizeOption == compactStyleOpt && !useArtworkBG) {
			self.artworkView.alpha = 0.0;
			self.artworkBackgroundView.alpha = 0.0;
		}

		// if (sharedEffectView) {
		// 	if ([sharedEffectView superview] != self) {
		// 		[self addSubview:sharedEffectView];
		// 	}
		// }
	} else if (self.isBCMMusicModule) {
		self.secondaryMarqueeView.transform = CGAffineTransformIdentity;
		self.secondaryMarqueeView.layer.anchorPoint = CGPointMake(0.5,0.5);
		self.artworkView._continuousCornerRadius = self.artworkBackgroundView._continuousCornerRadius;
	}
}

%new
- (UIView *)artworkBackgroundView {
	return self.artworkBackground;
}

%new
- (void)setTransformForSecondayView:(CGFloat)scale {
	self.secondaryMarqueeView.transform = CGAffineTransformMakeScale(scale, scale);
}

-(CGSize)layoutTextInAvailableBounds:(CGRect)arg2 setFrames:(BOOL)arg3 {
	// if (self.isBCMMusicModule && shouldFakeStyle) {
	// 	MSHookIvar<NSInteger>(self,"_style") = 0;
	// }
	CGSize result = %orig;
	if (self.isBCMMusicModule && shouldFakeStyle) {
		[self bcm_fixTextLayout];

		UIVisualEffectView *sharedEffectView = [self bcm_timeControlEffectView];

		if (sharedEffectView) {
			UIView *viewToUse = self.primaryMarqueeView;
			if (self.secondaryString && [self.secondaryString length] > 0) viewToUse = self.secondaryMarqueeView;
			CGFloat xOrigin = self.primaryMarqueeView.frame.origin.x;
			CGFloat width = self.frame.size.width - (15 + self.primaryMarqueeView.frame.origin.x);
			if (musicModSizeOption == compactStyleOpt) {
				xOrigin = 13;
				width = self.bounds.size.width - (xOrigin * 2);
			}
			sharedEffectView.frame = CGRectMake(xOrigin, viewToUse.frame.origin.y + viewToUse.frame.size.height, width, 34);
			sharedEffectView.alpha = 1.0;

		}

		MediaControlsTimeControl *sharedTimeControl = [self bcm_timeControl];
		if (sharedTimeControl && sharedEffectView) {
			CGRect timeControlFrame = sharedEffectView.bounds;
			timeControlFrame.origin.y = -20;
			timeControlFrame.size.height = 54;
			sharedTimeControl.frame = timeControlFrame;
			sharedTimeControl.alpha = 1.0;
		}
	}
	return result;
}
%end

%hook MediaControlsTransportStackView
%property (nonatomic, assign) BOOL isBCMMusicModule;
%end

// %hook MediaControlsContainerView
// %property (nonatomic, assign) BOOL isBCMMusicModule;
// - (void)setStyle:(NSInteger)style {
// 	if (self.isBCMMusicModule) {
// 		self.mediaControlsTransportStackView.isBCMMusicModule = self.isBCMMusicModule;
// 	}
// 	%orig;
// }
// %end

%hook MediaControlsParentContainerView
%property (nonatomic, assign) BOOL isBCMMusicModule;
- (void)setStyle:(NSInteger)style {
	if (self.isBCMMusicModule) {

		self.mediaControlsContainerView.isBCMMusicModule = self.isBCMMusicModule;
		// if (!sharedTimeControl) {
		// 	if (self.mediaControlsContainerView) {
		// 		sharedTimeControl = self.mediaControlsContainerView.mediaControlsTimeControl;
		// 		if (sharedTimeControl) sharedTimeControl.isBCMMusicModule = YES;
		// 	}
		// }
		// if (!sharedEffectView) {
		// 	if (self.mediaControlsContainerView) {
		// 		sharedEffectView = self.mediaControlsContainerView.primaryVisualEffectView;
		// 		if (sharedEffectView) sharedEffectView.isBCMMusicModule = YES;
		// 	}
		// }
		if (self.mediaControlsContainerView) {
			if (self.mediaControlsContainerView.mediaControlsTimeControl) {
				[self.mediaControlsContainerView.mediaControlsTimeControl cancelTrackingWithEvent:nil];
			}
		}
		// self.hidden = NO;
		// self.alpha = 1.0;
	}
	%orig;
}

- (void)layoutSubviews {
	if (self.isBCMMusicModule) {
		self.clipsToBounds = !shouldFakeStyle;
	}
	%orig;
	if (self.isBCMMusicModule) {
		self.clipsToBounds = !shouldFakeStyle;
	}
}

%new
- (id)mediaControlsContainerView {
	return self.containerView;
}
%end

%hook MediaControlsContainerView
%property (nonatomic, assign) BOOL isBCMMusicModule;
- (void)setStyle:(NSInteger)style {
	if (self.isBCMMusicModule) {
		self.mediaControlsTransportStackView.isBCMMusicModule = self.isBCMMusicModule;
		if (self.mediaControlsTimeControl) {
			self.mediaControlsTimeControl.isBCMMusicModule = YES;
		}
		if (self.primaryVisualEffectView) {
			self.primaryVisualEffectView.isBCMMusicModule = YES;
		}
	}

	// if (self.isBCMMusicModule && !shouldFakeStyle) {
	// 	if (self.primaryVisualEffectView) {
	// 		if ([self.primaryVisualEffectView superview] != self) {
	// 			[self addSubview:self.primaryVisualEffectView];
	// 			[self sendSubviewToBack:self.primaryVisualEffectView];
	// 		}
	// 	}
	// }
	%orig;
}

%new
- (id)mediaControlsTransportStackView {
	return self.transportStackView;
}
// - (void)setStyle:(NSInteger)style {
// 	if (style == 8) {
// 		%orig(0);
// 	} else {
// 		%orig;
// 	}
// }


- (void)layoutSubviews {
	if (self.isBCMMusicModule) {
		if (self.mediaControlsTimeControl) {
			self.mediaControlsTimeControl.isBCMMusicModule = YES;
			if (shouldFakeStyle) self.mediaControlsTimeControl.bcm_ignoreTimeFrameSet = YES;
		}
		if (self.primaryVisualEffectView) {
			self.primaryVisualEffectView.isBCMMusicModule = YES;
			if (shouldFakeStyle) self.primaryVisualEffectView.bcm_ignoreTimeFrameSet = YES;
		}
	}
	if (self.isBCMMusicModule && !shouldFakeStyle) {
		if (self.primaryVisualEffectView) {
			if ([self.primaryVisualEffectView superview] != self) {
				[self addSubview:self.primaryVisualEffectView];
				[self sendSubviewToBack:self.primaryVisualEffectView];
			}
		}
	}
	%orig;
	if (self.isBCMMusicModule) {
		if (self.mediaControlsTimeControl) self.mediaControlsTimeControl.bcm_ignoreTimeFrameSet = NO;
		if (self.primaryVisualEffectView) self.primaryVisualEffectView.bcm_ignoreTimeFrameSet = NO;
	}
}

%new
- (id)mediaControlsTimeControl {
	return self.timeControl;
}
%end

%hook MediaControlsTimeControl
%property (nonatomic, assign) BOOL isBCMMusicModule;
%property (nonatomic, retain) NSArray *savedTrackingConstraints;
%property (nonatomic, assign) BOOL bcm_ignoreTimeFrameSet;
- (void)setFrame:(CGRect)frame {
	if (self.isBCMMusicModule) {
		if (self.bcm_ignoreTimeFrameSet) return;
	}
	%orig;
}

-(void)updateLabelAvoidance {
	if (self.isBCMMusicModule && shouldFakeStyle) return;
	%orig;
}

- (void)layoutSubviews {
	if (self.isBCMMusicModule) {
		if (!self.savedTrackingConstraints) {
			NSArray *trackingConstraints = MSHookIvar<NSArray *>(self, "_trackingConstraints");
			if (trackingConstraints) {
				self.savedTrackingConstraints = trackingConstraints;
			}
		}

		if (self.savedTrackingConstraints) {
			if (shouldFakeStyle) {
				MSHookIvar<NSArray *>(self, "_trackingConstraints") = MSHookIvar<NSArray *>(self, "_defaultConstraints");
			} else {
				MSHookIvar<NSArray *>(self, "_trackingConstraints") = self.savedTrackingConstraints;
			}
		}
	}
	%orig;
}
%end

%hook UIVisualEffectView
%property (nonatomic, assign) BOOL isBCMMusicModule;
%property (nonatomic, assign) BOOL bcm_ignoreTimeFrameSet;
- (void)setFrame:(CGRect)frame {
	if (self.isBCMMusicModule) {
		if (self.bcm_ignoreTimeFrameSet) return;
	}
	%orig;
}
%end








// externc const CGFloat MediaControlsMaxWidthOfCondensedModule;


// %hook CCSModuleSettingsProvider
// -(NSArray *)orderedFixedModuleIdentifiers {
// 	NSArray *result = [NSArray arrayWithObjects:
// 		@"com.apple.control-center.ConnectivityModule",
// 		@"com.apple.mediaremote.controlcenter.nowplaying",
// 		@"com.apple.control-center.AudioModule",
// 		@"com.apple.control-center.DisplayModule",
// 		@"com.apple.mediaremote.controlcenter.airplaymirroring",
// 		@"com.apple.control-center.OrientationLockModule",
// 		@"com.apple.control-center.DoNotDisturbModule",
// 		nil];
// 	return result;
// }
// %end

%hook CCUIModuleSettingsManager
-(id)moduleSettingsForModuleIdentifier:(NSString *)identifier prototypeSize:(CCUILayoutSize)protoSize {
	if (identifier) {
		if ([identifier isEqualToString:@"com.apple.mediaremote.controlcenter.nowplaying"]) {
			CCUILayoutSize layoutSize;
			if (musicModSizeOption == 1) layoutSize = CCUILayoutSizeMake2(4,2);
			if (musicModSizeOption == 2) layoutSize = CCUILayoutSizeMake2(3,2);
			if (musicModSizeOption == 3 || musicModSizeOption == compactDisabledOpt) layoutSize = CCUILayoutSizeMake2(2,2);
			return [[NSClassFromString(@"CCUIModuleSettings") alloc] initWithPortraitLayoutSize:layoutSize landscapeLayoutSize:layoutSize];
		}
		if ([identifier isEqualToString:@"com.apple.control-center.ConnectivityModule"]) {
			CCUILayoutSize layoutSize;
			if (connectModSizeOption == 1) layoutSize = CCUILayoutSizeMake2(4,1);
			if (connectModSizeOption == 2) layoutSize = CCUILayoutSizeMake2(3,2);
			if (connectModSizeOption == 3) layoutSize = CCUILayoutSizeMake2(2,3);
			if (connectModSizeOption == 4) layoutSize = CCUILayoutSizeMake2(2,2);
			return [[NSClassFromString(@"CCUIModuleSettings") alloc] initWithPortraitLayoutSize:layoutSize landscapeLayoutSize:layoutSize];
		}
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"12.0")) {
			if ([identifier isEqualToString:@"com.atwiiks.betterccxi.weathermodule11"]) {
				CCUILayoutSize layoutSize;
				layoutSize = CCUILayoutSizeMake2(0,0);
				return [[NSClassFromString(@"CCUIModuleSettings") alloc] initWithPortraitLayoutSize:layoutSize landscapeLayoutSize:layoutSize];
			}
		}
		if ([identifier isEqualToString:@"com.atwiiks.betterccxi.weathermodule"] || [identifier isEqualToString:@"com.atwiiks.betterccxi.weathermodule11"]) {
			CCUILayoutSize layoutSize;
			if (weatherModSizeOption == 1) layoutSize = CCUILayoutSizeMake2(4,2);
			if (weatherModSizeOption == 2) layoutSize = CCUILayoutSizeMake2(4,1);
			if (weatherModSizeOption == 3) layoutSize = CCUILayoutSizeMake2(3,1);
			return [[NSClassFromString(@"CCUIModuleSettings") alloc] initWithPortraitLayoutSize:layoutSize landscapeLayoutSize:layoutSize];
		}
	}
	return %orig;
}
%end

%hook MediaControlsEndpointsViewController
- (MRPlatterViewController *)_createOrReuseViewController {
	MRPlatterViewController *controller = %orig;
	// if (musicModSizeOption == 3) return controller;
	if (controller && [controller isKindOfClass:NSClassFromString(@"MRPlatterViewController")]) {
		if (musicModSizeOption != compactDisabledOpt) {
			controller.isBCMMusicModule = YES;
			if ([self preferredExpandedContentHeight] > 0) {
				cachedExpandedHeight = [self preferredExpandedContentHeight];
			}
		}
	}
	return controller;
}

-(void)_adjustForEnvironmentChangeWithSize:(CGSize)size transitionCoordinator:(id)coordinator {
	// if (musicModSizeOption != 3) {
	if (musicModSizeOption != compactDisabledOpt) {

		for (UIViewController *viewController in self.childViewControllers) {
			MRPlatterViewController *controller = (MRPlatterViewController *)viewController;
			if (controller && [controller isKindOfClass:NSClassFromString(@"MRPlatterViewController")]) {
				controller.isBCMMusicModule = YES;
				MediaControlsTimeControl *sharedTimeControl = [controller bcm_timeControl];
				if (sharedTimeControl) {
					[sharedTimeControl cancelTrackingWithEvent:nil];
				}
			}
		}
		if ((size.height < [self preferredExpandedContentHeight] && size.height < 500)) {
			shouldFakeStyle = YES;
		} else {
			shouldFakeStyle = NO;
		}
	}
		// if (sharedTimeControl) {
		// 	[sharedTimeControl cancelTrackingWithEvent:nil];
		// }
	// }
	%orig;
}

-(void)_updateFramesForActiveViewControllersWithCoordinator:(id)coordinator assumingSize:(CGSize)size {
	// if (musicModSizeOption != 3) {
	if (musicModSizeOption != compactDisabledOpt) {
		if ([self respondsToSelector:@selector(displayMultipleDestinations)]) {
			if ((size.height < [self preferredExpandedContentHeight] && size.height < 500)) self.displayMultipleDestinations = false;
		} else if ([self respondsToSelector:@selector(displayMode)]) {
			if ((size.height < [self preferredExpandedContentHeight] && size.height < 500)) self.displayMode = 0;
		}
	}
	// }
	%orig;
}

-(void)_transitionToDisplayMode:(NSInteger)arg2 usingTransitionCoordinator:(id)arg3 assumingSize:(CGSize)arg4 {
	if (shouldFakeStyle) arg2 = 0;
	%orig(arg2,arg3,arg4);
}

- (void)viewWillAppear:(BOOL)willAppear {
	%orig;
	if (musicModSizeOption != compactDisabledOpt) {

		for (UIViewController *viewController in self.childViewControllers) {
			MRPlatterViewController *controller = (MRPlatterViewController *)viewController;
			if (controller && [controller isKindOfClass:NSClassFromString(@"MRPlatterViewController")]) {
				controller.isBCMMusicModule = YES;
			}
		}

		CGSize size = self.view.bounds.size;
		if ([self respondsToSelector:@selector(displayMultipleDestinations)]) {
			if ((size.height < [self preferredExpandedContentHeight] && size.height < 500)) self.displayMultipleDestinations = false;
		} else if ([self respondsToSelector:@selector(displayMode)]) {
			if ((size.height < [self preferredExpandedContentHeight] && size.height < 500)) self.displayMode = 0;
		}

		if ([self respondsToSelector:@selector(_adjustForEnvironmentChangeWithSize:transitionCoordinator:)]) {
			[self _adjustForEnvironmentChangeWithSize:size transitionCoordinator:nil];
		}

		if ([self respondsToSelector:@selector(viewWillTransitionToSize:)]) {

			[self viewWillTransitionToSize:self.view.bounds.size];
		}

		if ([self respondsToSelector:@selector(_updateContentInsets)]) {
			[self _updateContentInsets];
		}

		if ([self respondsToSelector:@selector(_updateContentSize)]) {
			[self _updateContentSize];
		}

		for (UIViewController *viewController in self.childViewControllers) {
			MRPlatterViewController *controller = (MRPlatterViewController *)viewController;
			if (controller && [controller isKindOfClass:NSClassFromString(@"MRPlatterViewController")]) {
				if ([controller respondsToSelector:@selector(_updateStyle)]) {
					if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2") || SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"12.2")) {
						controller.style = 1;
						[controller _updateStyle];
						controller.style = 1;
						[controller _updateStyle];
						//[controller willTransitionToSize:self.view.bounds.size];
					}
				}

				MediaControlsTimeControl *sharedTimeControl = [controller bcm_timeControl];
				if (sharedTimeControl) {
					[sharedTimeControl cancelTrackingWithEvent:nil];
				}
			}
		}
	}

	// [self willTransitionToSize:self.view.bounds.size];
	// if (musicModSizeOption != 3) {
		// [self viewDidLayoutSubviews];
		// if (sharedTimeControl) {
		// 	[sharedTimeControl cancelTrackingWithEvent:nil];
		// }

	// }
}
%end

#import <ControlCenterUI/CCUIControlCenterPositionProviderPackingRule.h>

%hook CCUIControlCenterPositionProviderPackingRule
-(id)initWithPackFrom:(NSUInteger)packFrom packingOrder:(NSUInteger)packingOrder sizeLimit:(CCUILayoutSize)sizeLimit {

	if (isPad) {
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"12.0")) {
			if (connectModSizeOption == 2 || musicModSizeOption == 2 || weatherModSizeOption > 1) sizeLimit.width = 3;
			if (connectModSizeOption == 1 || musicModSizeOption == 1 || weatherModSizeOption == 1) sizeLimit.width = 4;
			sizeLimit.height = NSUIntegerMax;
			return %orig(0, 0, CCUILayoutSizeMake2(sizeLimit.width, sizeLimit.height));
		} else {
			sizeLimit.width = NSUIntegerMax;
			return %orig(0, 1, CCUILayoutSizeMake2(sizeLimit.width, sizeLimit.height));
		}
	} else {
		return %orig;
	}
}

%new
- (NSUInteger)sizeLimitHeight {
	return [self sizeLimit].height;
}
%end

// %hook MSHJelloView
// %property (nonatomic, assign) BOOL ignoreDisconnect;


// - (void)msdDisconnect {
// 	if (self.ignoreDisconnect) return;
// 	%orig;
// }

// %new
// - (void)bcm_test {

// }
// %end

// %hook CCUIControlCenterPositionProviderPackingRule
// -(id)initWithPackFrom:(NSUInteger)packFrom packingOrder:(NSUInteger)packingOrder sizeLimit:(CCUILayoutSize)sizeLimit {
// 	packingOrder = 0;
// 	sizeLimit.width = 4;
// 	packFrom = 1;
// 	return %orig(1, 0, CCUILayoutSizeMake2(4, sizeLimit.height));
// }

// - (NSUInteger)packingOrder {
// 	return 0;
// }

// - (NSUInteger)packFrom {
// 	return 1;
// }
// %end

static void loadSettings() {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", @"com.atwiiks.betterccxi"];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];

	globalSettings = settings;

	connectModSizeOption = (NSInteger)[[globalSettings objectForKey:@"connectModuleSize"]?:@1 integerValue];
	musicModSizeOption = (NSInteger)[[globalSettings objectForKey:@"musicModuleSize"]?:@1 integerValue];
	weatherModSizeOption = (NSInteger)[[globalSettings objectForKey:@"weatherModuleSize"]?:@1 integerValue];
	if (musicModSizeOption == compactDisabledOpt) shouldFakeStyle = NO;
	useArtworkBG = (BOOL)[[globalSettings objectForKey:@"useArtworkBG"]?:@YES boolValue];
}


%group IOS113
%hook MediaControlsHeaderView
%new
- (id)titleMarqueeView {
	return (MPUMarqueeView *)[self routeLabel];
}
%end
%end


%ctor {
	if (NSClassFromString(@"MRPlatterViewController")) {
		dlopen("/Library/MobileSubstrate/DynamicLibraries/MitsuhaXISpringboard.dylib", RTLD_NOW);
		loadSettings();
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.3")) {
			%init(IOS113);
		}
		%init;
	}
}

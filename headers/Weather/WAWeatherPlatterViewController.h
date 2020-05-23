#import "WATodayHeaderView.h"

@interface WAWeatherPlatterViewController : UIViewController
-(id)init;
-(id)initWithLocation:(id)arg1;
@property (nonatomic,retain) NSArray<UIView *> *hourlyForecastViews;
@property (nonatomic,retain) UIView *dividerLineView;
@property (nonatomic,retain) WATodayHeaderView *headerView;
- (void)_contentSizeDidUpdate:(id)something;
- (void)_buildModelForLocation:(id)location;
- (void)setModel:(id)model;
- (void)_updateViewContent;
@end
@interface WATodayHeaderView : UIView
@property (nonatomic,retain) UIVisualEffectView * locationLabelVisualEffectView;                        //@synthesize locationLabelVisualEffectView=_locationLabelVisualEffectView - In the implementation block
@property (nonatomic,retain) UIVisualEffectView * conditionsLabel1VisualEffectView;                     //@synthesize conditionsLabel1VisualEffectView=_conditionsLabel1VisualEffectView - In the implementation block
@property (nonatomic,retain) UIVisualEffectView * conditionsLabel2VisualEffectView;                     //@synthesize conditionsLabel2VisualEffectView=_conditionsLabel2VisualEffectView - In the implementation block
@property (nonatomic,retain) UIVisualEffectView * temperatureLabelVisualEffectView;                     //@synthesize temperatureLabelVisualEffectView=_temperatureLabelVisualEffectView - In the implementation block
@property (nonatomic,retain) UIVisualEffectView * temperatureHighLowLabelVisualEffectView;              //@synthesize temperatureHighLowLabelVisualEffectView=_temperatureHighLowLabelVisualEffectView - In the implementation block
@property (nonatomic,retain) UILabel * locationLabel;                                                   //@synthesize locationLabel=_locationLabel - In the implementation block
@property (nonatomic,retain) UILabel * conditionsLabel1;                                                //@synthesize conditionsLabel1=_conditionsLabel1 - In the implementation block
@property (nonatomic,retain) UILabel * conditionsLabel2;                                                //@synthesize conditionsLabel2=_conditionsLabel2 - In the implementation block
@property (nonatomic,retain) UIImageView * conditionsImageView;                                         //@synthesize conditionsImageView=_conditionsImageView - In the implementation block
@property (nonatomic,retain) UILabel * temperatureLabel;                                                //@synthesize temperatureLabel=_temperatureLabel - In the implementation block
@property (nonatomic,retain) UILabel * temperatureHighLowLabel;                                         //@synthesize temperatureHighLowLabel=_temperatureHighLowLabel - In the implementation block
@property (assign,nonatomic) double pageFontSize;                                                       //@synthesize pageFontSize=_pageFontSize - In the implementation block
@property (assign,nonatomic) double pageDegreeFontSize;                                                 //@synthesize pageDegreeFontSize=_pageDegreeFontSize - In the implementation block
@property (assign,nonatomic) double pageBaselineOffset;                                                 //@synthesize pageBaselineOffset=_pageBaselineOffset - In the implementation block
@property (nonatomic,retain) NSArray * contentViewConstraints;                                          //@synthesize contentViewConstraints=_contentViewConstraints - In the implementation block
@property (nonatomic,retain) NSArray * masterConstraints;                                               //@synthesize masterConstraints=_masterConstraints - In the implementation block
@property (nonatomic,copy) NSString * conditionsLine1;                                                  //@synthesize conditionsLine1=_conditionsLine1 - In the implementation block
@property (nonatomic,copy) NSString * conditionsLine2;                                                  //@synthesize conditionsLine2=_conditionsLine2 - In the implementation block
@property (nonatomic,copy) UIImage * conditionsImage;                                                   //@synthesize conditionsImage=_conditionsImage - In the implementation block
@property (nonatomic,copy) NSString * temperature;                                                      //@synthesize temperature=_temperature - In the implementation block
@property (nonatomic,copy) NSString * temperatureHigh;                                                  //@synthesize temperatureHigh=_temperatureHigh - In the implementation block
@property (nonatomic,copy) NSString * temperatureLow;                                                   //@synthesize temperatureLow=_temperatureLow - In the implementation block
@property (nonatomic,copy) NSString * locationName;
- (void)_setupSubviews;
- (void)_updateContent;
@end    
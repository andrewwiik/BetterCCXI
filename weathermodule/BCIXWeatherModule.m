#import "BCIXWeatherModule.h"

@implementation BCIXWeatherModule

//Return the icon of your module here
- (instancetype)init {
  
  self = [super init];
  if (self) {
    _contentViewController = [[BCIWeatherContentViewController alloc]init];
  }
  return self;
}
@end

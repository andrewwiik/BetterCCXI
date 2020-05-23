#include "BCMRootListController.h"
#include <spawn.h>
#import <Preferences/PSSpecifier.h>

#define kPrefsPath @"/var/mobile/Library/Preferences/"

@implementation BCMRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	[super setPreferenceValue:value specifier:specifier];
	NSString *path = [kPrefsPath stringByAppendingString:specifier.properties[@"defaults"]];

    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    
    if([defaults writeToFile:path atomically:YES])
    {
        //all good do nothing
    } else{
        //NSLog(@"FAILED WRITING SETTINGS");
    }
    
    CFStringRef toPost = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
    if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);


}


- (void)respring {
  pid_t pid;
  int status;
  const char* args[] = {"killall", "-9", "backboardd", NULL};
  posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
  waitpid(pid, &status, WEXITED);
}
@end

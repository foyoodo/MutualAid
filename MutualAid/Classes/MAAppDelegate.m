//
//  MAAppDelegate.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import "MAAppDelegate.h"
#import "MATabBarController.h"

@interface MAAppDelegate ()

@end

@implementation MAAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [MATabBarController new];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

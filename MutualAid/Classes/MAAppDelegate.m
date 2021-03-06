//
//  MAAppDelegate.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import "MAAppDelegate.h"
#import "MATabBarController.h"
#import <UserNotifications/UserNotifications.h>
#import "MAArtwork.h"
#import "MAMapPointViewController.h"
#import "CTMediator+HandyTools.h"

@interface MAAppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation MAAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [MATabBarController new];
    [self.window makeKeyAndVisible];

    [self registerForLocalNotifications];

    [UNUserNotificationCenter currentNotificationCenter].delegate = self;

    return YES;
}

- (void)registerForLocalNotifications {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            [MAToast showMessage:@"请手动开启通知权限" inView:self.window];
        }
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {

    NSDictionary *userInfo = response.notification.request.content.userInfo;

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([userInfo[@"latitude"] doubleValue], [userInfo[@"longitude"] doubleValue]);

    MAMapPointViewController *vc = [MAMapPointViewController new];

    MAArtwork *artwork = [[MAArtwork alloc] initWithTitle:userInfo[@"title"] ?: @"患者所在位置" locationName:userInfo[@"detail"] ?: @"点击图标赶往急救现场" coordinate:coordinate];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [CT() presentViewController:nav animated:YES completion:^{
        [vc pointToTargetAnnotation:artwork];
    }];
}

@end

//
//  MATabBarController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import "MATabBarController.h"

@interface MATabBarController () <UITabBarControllerDelegate>

@end

@implementation MATabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewControllers = @[
        tabBarItemWithName(@"Home", @"home_normal", @"home_highlight"),
        tabBarItemWithName(@"Map", @"map_normal", @"map_highlight"),
        tabBarItemWithName(@"Mine", @"mine_normal", @"mine_highlight")
    ];
    self.delegate = self;

    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    }
}

#pragma mark - Private Methods

static inline UIViewController *tabBarItemWithName(NSString *name, NSString *image, NSString *selectedImage) {
    Class clz = NSClassFromString([NSString stringWithFormat:@"MA%@ViewController", name]);
    UIViewController *vc = [clz new] ?: [UIViewController new];
    vc.title = name.localized;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

@end

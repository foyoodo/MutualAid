//
//  MATabBarController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import "MATabBarController.h"
#import "MANavigationController.h"
#import "MAFloatingButton.h"

@interface MATabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) MAFloatingButton *floatingButton;

@end

@implementation MATabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[
        tabBarItemWithName(@"Home", @"home_normal", @"home_highlight"),
        tabBarItemWithName(@"Map", @"map_normal", @"map_highlight"),
        tabBarItemWithName(@"Mine", @"mine_normal", @"mine_highlight")
    ];
    self.delegate = self;

    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    }

    [self tabBarController:self didSelectViewController:self.viewControllers.firstObject];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGRect frame = self.floatingButton.frame;
    frame.origin.x = self.view.frame.size.width - frame.size.width - 8;
    frame.origin.y = self.view.frame.size.height - frame.size.height - self.tabBar.frame.size.height - 8;
    self.floatingButton.frame = frame;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    CGRect frame = self.floatingButton.frame;
    frame.origin.y -= self.view.safeAreaInsets.bottom;
    self.floatingButton.frame = frame;
}

#pragma mark - Private Methods

static inline UIViewController *tabBarItemWithName(NSString *name, NSString *image, NSString *selectedImage) {
    Class clz = NSClassFromString([NSString stringWithFormat:@"MA%@ViewController", name]);
    UIViewController *vc = [clz new] ?: [UIViewController new];
    vc.title = name.localized;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[MANavigationController alloc] initWithRootViewController:vc];
    return nav;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:UINavigationController.class]) {
        [((UINavigationController *)viewController).viewControllers.firstObject.view addSubview:self.floatingButton];
    }
}

#pragma mark - Lazy Load

- (MAFloatingButton *)floatingButton {
    if (!_floatingButton) {
        _floatingButton = [MAFloatingButton new];
    }
    return _floatingButton;
}

@end

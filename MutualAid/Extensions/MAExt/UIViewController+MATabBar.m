//
//  UIViewController+MATabBar.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/16.
//

#import "UIViewController+MATabBar.h"
#import <objc/runtime.h>

@interface UITabBarController (MATabBarPrivate)

@property (nonatomic, assign) BOOL ma_tabBarHidden;

@end

@implementation UITabBarController (MATabBarPrivate)

- (BOOL)ma_tabBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setMa_tabBarHidden:(BOOL)ma_tabBarHidden {
    objc_setAssociatedObject(self, @selector(ma_tabBarHidden), @(ma_tabBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIViewController (MATabBar)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewWillAppear_originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method viewWillAppear_swizzledMethod = class_getInstanceMethod(self, @selector(ma_viewWillAppear:));
        method_exchangeImplementations(viewWillAppear_originalMethod, viewWillAppear_swizzledMethod);

        Method viewDidAppear_originalMethod = class_getInstanceMethod(self, @selector(viewDidAppear:));
        Method viewDidAppear_swizzledMethod = class_getInstanceMethod(self, @selector(ma_viewDidAppear:));
        method_exchangeImplementations(viewDidAppear_originalMethod, viewDidAppear_swizzledMethod);
    });
}

- (void)ma_viewWillAppear:(BOOL)animated {
    [self ma_viewWillAppear:animated];

    if (self.ma_prefersTabBarHidden && !self.tabBarController.ma_tabBarHidden) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.tabBarController.tabBar.frame;
            frame.origin.y += self.tabBarController.tabBar.frame.size.height;
            self.tabBarController.tabBar.frame = frame;
        } completion:^(BOOL finished) {
            self.tabBarController.ma_tabBarHidden = YES;
        }];
    }
}

- (void)ma_viewDidAppear:(BOOL)animated {
    [self ma_viewDidAppear:animated];

    if (self.tabBarController.ma_tabBarHidden && !self.ma_prefersTabBarHidden) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.tabBarController.tabBar.frame;
            frame.origin.y -= self.tabBarController.tabBar.frame.size.height;
            self.tabBarController.tabBar.frame = frame;
        } completion:^(BOOL finished) {
            self.tabBarController.ma_tabBarHidden = NO;
        }];
    }
}

- (BOOL)ma_prefersTabBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setMa_prefersTabBarHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(ma_prefersTabBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

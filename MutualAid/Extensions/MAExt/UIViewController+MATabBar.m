//
//  UIViewController+MATabBar.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/16.
//

#import "UIViewController+MATabBar.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const NSTimeInterval kAnimationDuration = 0.25;

@interface UITabBarController (MATabBarPrivate)

@property (nonatomic, assign) CGFloat ma_height;

@property (nonatomic, assign) BOOL ma_tabBarHidden;

@end

@implementation UITabBarController (MATabBarPrivate)

- (void)ma_viewDidAppear:(BOOL)animated {
    struct objc_super superObj = {
        .receiver = self,
        .super_class = [UIViewController class]
    };
    ((void(*)(struct objc_super *, SEL, BOOL))(objc_msgSendSuper))(&superObj, @selector(ma_viewDidAppear:), animated);

    self.ma_height = self.tabBar.frame.size.height;
}

- (CGFloat)ma_height {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMa_height:(CGFloat)ma_height {
    objc_setAssociatedObject(self, @selector(ma_height), @(ma_height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

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
        self.tabBarController.ma_tabBarHidden = YES;
        [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.tabBarController.tabBar.frame;
            frame.origin.y += self.tabBarController.ma_height;
            self.tabBarController.tabBar.frame = frame;
        } completion:nil];
    }
}

- (void)ma_viewDidAppear:(BOOL)animated {
    [self ma_viewDidAppear:animated];

    if (self.tabBarController.ma_tabBarHidden && !self.ma_prefersTabBarHidden) {
        self.tabBarController.ma_tabBarHidden = NO;
        [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.tabBarController.tabBar.frame;
            frame.origin.y -= self.tabBarController.ma_height;
            self.tabBarController.tabBar.frame = frame;
        } completion:nil];
    }
}

- (BOOL)ma_prefersTabBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setMa_prefersTabBarHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(ma_prefersTabBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

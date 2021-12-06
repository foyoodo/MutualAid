//
//  MASearchNavigationControllerDelegate.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import "MASearchNavigationControllerDelegate.h"
#import "MASearchAnimatedTransition.h"

@interface MASearchNavigationControllerDelegate ()

@end

@implementation MASearchNavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    Class clz = NSClassFromString(@"MASearchViewController");
    if ([fromVC isKindOfClass:clz] || [toVC isKindOfClass:clz]) {
        return [MASearchAnimatedTransition new];
    }
    return nil;
}

@end

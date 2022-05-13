//
//  MASearchNavigationControllerDelegate.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import "MASearchNavigationControllerDelegate.h"
#import "MASearchAnimatedTransition.h"
#import "MAScaleAnimationController.h"
#import "MAPanInteractionController.h"

@interface MASearchNavigationControllerDelegate ()

@property (nonatomic, strong) MAPanInteractionController *interactionController;

@end

@implementation MASearchNavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    Class clz = NSClassFromString(@"MASearchViewController");
    if ([fromVC isKindOfClass:clz] || [toVC isKindOfClass:clz]) {
        return [MASearchAnimatedTransition new];
    }

    MAScaleAnimationController *animationController = [MAScaleAnimationController new];
    if (operation == UINavigationControllerOperationPop) {
        animationController.reverse = YES;
    }

    return animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController.interactive ? self.interactionController : nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.interactionController wireToViewController:viewController forOperation:MAInteractionOperationPop];
}

- (MAPanInteractionController *)interactionController {
    if (!_interactionController) {
        _interactionController = [MAPanInteractionController new];
    }
    return _interactionController;
}

@end

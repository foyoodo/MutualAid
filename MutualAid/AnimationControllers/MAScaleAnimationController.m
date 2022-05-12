//
//  MAScaleAnimationController.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/12.
//

#import "MAScaleAnimationController.h"

@implementation MAScaleAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor clearColor];

    [containerView addSubview:toView];

    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;

    if (!self.reverse) {
        fromViewTransform = CGAffineTransformMakeScale(0.9, 0.9);
        toViewTransform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0);
    } else {
        fromViewTransform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0);
        toViewTransform = CGAffineTransformMakeScale(0.9, 0.9);

        [containerView sendSubviewToBack:toView];
    }

    toView.transform = toViewTransform;

    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut;
    if (transitionContext.interactive) {
        options = UIViewAnimationOptionCurveLinear;
    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:options animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

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

    UIView *scaleView = fromView;
    CGFloat scaleViewFromCornerRadius = 40;
    CGFloat scaleViewtoCornerRadius = 6;

    if (!self.reverse) {
        fromViewTransform = CGAffineTransformMakeScale(0.9, 0.9);
        toViewTransform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0);
    } else {
        fromViewTransform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0);
        toViewTransform = CGAffineTransformMakeScale(0.9, 0.9);

        scaleView = toView;
        scaleViewFromCornerRadius = 6;
        scaleViewtoCornerRadius = 40;

        [containerView sendSubviewToBack:toView];
    }

    toView.transform = toViewTransform;
    scaleView.layer.masksToBounds = YES;
    scaleView.layer.cornerRadius = scaleViewFromCornerRadius;

    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut;
    if (transitionContext.interactive) {
        options = UIViewAnimationOptionCurveLinear;
    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:options animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
        scaleView.layer.cornerRadius = scaleViewtoCornerRadius;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        scaleView.layer.cornerRadius = 0;

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

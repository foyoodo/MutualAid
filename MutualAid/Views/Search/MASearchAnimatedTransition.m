//
//  MASearchAnimatedTransition.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import "MASearchAnimatedTransition.h"
#import "MASearchBar.h"

@interface MASearchAnimatedTransition ()

@property (nonatomic, weak) MASearchView *fromSearchView;

@end

@implementation MASearchAnimatedTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController<MASearchBarDelegate> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController<MASearchBarDelegate> *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];

    MASearchView *fromSearchView = (_fromSearchView = fromVC.searchBar.searchView);
    MASearchView *toSearchView = toVC.searchBar.searchView;

    MASearchView *tempSearchView = [MASearchView new];
    tempSearchView.frame = [fromVC.view convertRect:fromSearchView.frame fromView:fromVC.searchBar];
    tempSearchView.layer.cornerRadius = fromSearchView.layer.cornerRadius;

    [tempSearchView layoutIfNeeded];
    fromSearchView.hidden = YES;
    toSearchView.hidden = YES;

    [containerView addSubview:toVC.view];

    CGRect toSearchViewFrame = [toVC.view convertRect:toSearchView.frame fromView:toVC.searchBar];

    Class clz = NSClassFromString(@"MASearchViewController");
    if ([toVC isKindOfClass:clz]) {
        [containerView addSubview:tempSearchView];

        toVC.view.alpha = 0.0;

        toSearchViewFrame.origin.y += containerView.safeAreaInsets.top;

        [tempSearchView prepareForTransitionIfShow:YES];

        [UIView animateWithDuration:transitionDuration animations:^{
            tempSearchView.frame = toSearchViewFrame;
            tempSearchView.layer.borderColor = [UIColor accentColor].CGColor;
            toVC.view.alpha = 1.0;
            [tempSearchView layoutIfNeeded];
        } completion:^(BOOL finished) {
            toSearchView.hidden = NO;
            [tempSearchView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }

    if ([fromVC isKindOfClass:clz]) {
        [containerView addSubview:fromVC.view];
        [containerView addSubview:tempSearchView];

        tempSearchView.layer.borderColor = [UIColor accentColor].CGColor;

        [tempSearchView prepareForTransitionIfShow:YES];
        [tempSearchView layoutIfNeeded];
        [tempSearchView prepareForTransitionIfShow:NO];

        [UIView animateWithDuration:transitionDuration animations:^{
            tempSearchView.frame = toSearchViewFrame;
            tempSearchView.layer.borderColor = tempSearchView.backgroundColor.CGColor;
            fromVC.view.alpha = 0.0;
            [tempSearchView layoutIfNeeded];
        } completion:^(BOOL finished) {
            toSearchView.hidden = NO;
            [tempSearchView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];

    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if (transitionCompleted) {
        self.fromSearchView.hidden = NO;
    }
}

@end

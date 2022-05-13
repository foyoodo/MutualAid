//
//  MAPanInteractionController.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/12.
//

#import "MAPanInteractionController.h"
#import <objc/runtime.h>
#import "MANavigationCornerView.h"

const void *kMAHorizontalPanGestureKey = &kMAHorizontalPanGestureKey;

@implementation MAPanInteractionController {
    BOOL _shouldCompleteTransition;
}

- (void)wireToViewController:(UIViewController *)viewController forOperation:(MAInteractionOperation)operation {
    [super wireToViewController:viewController forOperation:operation];

    [self prepareGestureRecognizerForView:viewController.view];
}

- (void)prepareGestureRecognizerForView:(UIView *)view {
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(view, kMAHorizontalPanGestureKey);

    if (pan) {
        [view removeGestureRecognizer:pan];
    }

    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [view addGestureRecognizer:pan];

    objc_setAssociatedObject(view, kMAHorizontalPanGestureKey, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view.superview];
    CGPoint vel = [pan velocityInView:pan.view];

    BOOL right2Left = vel.x < 0;

    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            if (right2Left) {
                break;
            }
            if (self.operation == MAInteractionOperationPop) {
                self.interactive = YES;
                [self.viewController.navigationController popViewControllerAnimated:YES];
                [[MANavigationCornerView sharedInstance] startInteractiveTransitionWithViewController:self.viewController];
            } else if (self.operation == MAInteractionOperationDismiss) {
                // dismiss
            }
            break;
        }

        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = translation.x / pan.view.frame.size.width;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            _shouldCompleteTransition = (fraction > 0.5);

            [self updateInteractiveTransition:fraction];
            [[MANavigationCornerView sharedInstance] updateInteractiveTransition:fraction panGesture:pan];

            self.interactive = YES;
            break;
        }

        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.completionSpeed = 0.5;
            if (!_shouldCompleteTransition || pan.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
                [[MANavigationCornerView sharedInstance] cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
                [[MANavigationCornerView sharedInstance] finishInteractiveTransition];
            }
            self.interactive = NO;
            break;
        }

        default:
            break;
    }
}

@end

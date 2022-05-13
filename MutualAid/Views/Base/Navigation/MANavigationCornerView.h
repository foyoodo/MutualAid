//
//  MANavigationCornerView.h
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MANavigationCornerView : UIView

+ (instancetype)sharedInstance;

- (void)startInteractiveTransitionWithViewController:(UIViewController *)viewController;
- (void)updateInteractiveTransition:(CGFloat)percentComplete panGesture:(nullable UIPanGestureRecognizer *)pan;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@property (nonatomic, assign, readonly) BOOL interactive;

@end

NS_ASSUME_NONNULL_END

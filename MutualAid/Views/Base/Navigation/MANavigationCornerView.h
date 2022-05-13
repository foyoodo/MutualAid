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

- (void)startInteractiveTransition;
- (void)updateInteractiveTransition:(CGFloat)percentComplete panGesture:(nullable UIPanGestureRecognizer *)pan;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@end

NS_ASSUME_NONNULL_END

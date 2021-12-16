//
//  UIView+FYExt.h
//  FYCategories
//
//  Created by foyoodo on 2021/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FYExt)

@property (nonatomic, weak, readonly) UIViewController *viewController;

- (void)roundedWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;

@end

NS_ASSUME_NONNULL_END

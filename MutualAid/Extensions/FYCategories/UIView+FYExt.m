//
//  UIView+FYExt.m
//  FYCategories
//
//  Created by foyoodo on 2021/9/30.
//

#import "UIView+FYExt.h"

@implementation UIView(FYExt)

- (void)roundedWithRadius:(CGFloat)radius corner:(UIRectCorner)corner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

@end

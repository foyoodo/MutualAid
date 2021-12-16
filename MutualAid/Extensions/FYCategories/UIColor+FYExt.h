//
//  UIColor+FYExt.h
//  FYCategories
//
//  Created by foyoodo on 2021/10/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FYExt)

+ (UIColor *)colorWithHex:(int)hex;
+ (UIColor *)colorWithHex:(int)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END

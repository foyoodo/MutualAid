//
//  UIColor+FYExt.m
//  FYCategories
//
//  Created by foyoodo on 2021/10/1.
//

#import "UIColor+FYExt.h"

@implementation UIColor(FYExt)

+ (UIColor *)colorWithHex:(int)hex {
    return [UIColor colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(int)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0x00FF00) >>  8)) / 255.0
                            blue:((float)((hex & 0x0000FF) >>  0)) / 255.0
                           alpha:alpha];
}

@end

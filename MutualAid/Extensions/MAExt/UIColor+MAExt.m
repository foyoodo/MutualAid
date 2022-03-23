//
//  UIColor+MAExt.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/23.
//

#import "UIColor+MAExt.h"
#import "UIColor+FYExt.h"

@implementation UIColor (MAExt)

+ (UIColor *)accentColor {
    static UIColor *accentColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accentColor = [UIColor colorNamed:@"AccentColor"];
    });
    return accentColor;
}

+ (UIColor *)chalkColor {
    static UIColor *chalkColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chalkColor = [UIColor colorWithHex:0xECF0F1];
    });
    return chalkColor;
}

+ (UIColor *)midnightColor {
    static UIColor *midnightColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        midnightColor = [UIColor colorWithHex:0x34495E];
    });
    return midnightColor;
}

+ (UIColor *)stoneColor {
    static UIColor *stoneColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stoneColor = [UIColor colorWithHex:0x95A5A6];
    });
    return stoneColor;
}

@end

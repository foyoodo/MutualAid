//
//  UIImage+FYExt.m
//  FYCategories
//
//  Created by foyoodo on 2021/9/30.
//

#import "UIImage+FYExt.h"

@implementation UIImage(FYExt)

+ (instancetype)imageWithSymbol:(NSString *)name {
    if (@available(iOS 13.0, *)) {
        return [UIImage systemImageNamed:name];
    } else {
        return [UIImage imageNamed:name];
    }
}

+ (instancetype)imageWithSymbol:(NSString *)name height:(CGFloat)height {
    return [[UIImage imageWithSymbol:name] resizeWithHeight:height];
}

+ (instancetype)imageWithSymbol:(NSString *)name height:(CGFloat)height color:(UIColor *)color {
    if (@available(iOS 13.0, *)) {
        return [[UIImage imageWithSymbol:name height:height] imageWithTintColor:color];
    } else {
        return [UIImage imageWithSymbol:name height:height];
    }
}

- (instancetype)resizeWithHeight:(CGFloat)height {
    UIImage *image = nil;
    if (self != nil) {
        CGSize size = self.size;
        size.width = size.width*height / size.height;
        size.height = height;
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}

@end

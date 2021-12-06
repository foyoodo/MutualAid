//
//  UIImage+FYExt.h
//  FYCategories
//
//  Created by foyoodo on 2021/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(FYExt)

+ (instancetype)imageWithSymbol:(NSString *)name;
+ (instancetype)imageWithSymbol:(NSString *)name height:(CGFloat)height;
+ (instancetype)imageWithSymbol:(NSString *)name height:(CGFloat)height color:(UIColor *)color;

- (instancetype)resizeWithHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END

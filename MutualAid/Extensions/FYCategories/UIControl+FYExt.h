//
//  UIControl+FYExt.h
//  FYCategories
//
//  Created by foyoodo on 2021/10/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (FYExt)

- (instancetype)initWithActionBlock:(void (^)(id sender))block forControlEvents:(UIControlEvents)events;

- (void)addActionBlock:(void (^)(id sender))block forControlEvents:(UIControlEvents)events;

@end

NS_ASSUME_NONNULL_END

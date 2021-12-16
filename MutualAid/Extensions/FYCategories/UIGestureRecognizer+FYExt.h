//
//  UIGestureRecognizer+FYExt.h
//  FYCategories
//
//  Created by foyoodo on 2021/10/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (FYExt)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;

@end

NS_ASSUME_NONNULL_END

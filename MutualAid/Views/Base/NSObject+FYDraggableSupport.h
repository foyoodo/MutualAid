//
//  NSObject+FYDraggableSupport.h
//  MutualAid
//
//  Created by foyoodo on 2022/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FYDraggableSupport)

- (void)fy_draggableSupportRunAtDealloc:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END

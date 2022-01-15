//
//  NSObject+FYDraggableSupport.m
//  MutualAid
//
//  Created by foyoodo on 2022/1/15.
//

#import "NSObject+FYDraggableSupport.h"
#import <objc/runtime.h>

@interface _FYDraggableSupportBlockTarget : NSObject

- (instancetype)initWithBlock:(void (^)(void))aBlock;

@property (nonatomic, copy) void (^block)(void);

@end

@implementation _FYDraggableSupportBlockTarget

- (void)dealloc
{
    !_block ?: _block();
}

- (instancetype)init
{
    return [self initWithBlock:nil];
}

- (instancetype)initWithBlock:(void (^)(void))block
{
    if (self = [super init]) {
        _block = block;
    }
    return self;
}

@end

@implementation NSObject (FYDraggableSupport)

static const void *fy_draggableSupportRunAtDeallocBlockTargetKey = &fy_draggableSupportRunAtDeallocBlockTargetKey;

- (void)fy_draggableSupportRunAtDealloc:(void (^)(void))block
{
    if (block) {
        _FYDraggableSupportBlockTarget *target = [[_FYDraggableSupportBlockTarget alloc] initWithBlock:block];

        objc_setAssociatedObject(self, fy_draggableSupportRunAtDeallocBlockTargetKey, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end

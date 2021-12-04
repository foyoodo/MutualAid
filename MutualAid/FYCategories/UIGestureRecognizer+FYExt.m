//
//  UIGestureRecognizer+FYExt.m
//  FYCategories
//
//  Created by foyoodo on 2021/10/1.
//

#import "UIGestureRecognizer+FYExt.h"
#import <objc/runtime.h>

@interface _FYUIGestureRecognizerBlockTarget : NSObject

- (instancetype)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@property (nonatomic, copy) void (^block)(id sender);

@end

@implementation _FYUIGestureRecognizerBlockTarget

- (instancetype)initWithBlock:(void (^)(id sender))block{
    if (self = [super init]) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    !_block ?: _block(sender);
}

@end

@implementation UIGestureRecognizer(FYExt)

- (instancetype)initWithActionBlock:(void (^)(id _Nonnull sender))block {
    if (self = [self init]) {
        [self addActionBlock:block];
    }
    return self;
}

- (void)addActionBlock:(void (^)(id sender))block {
    _FYUIGestureRecognizerBlockTarget *target = [[_FYUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self _fy_UIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (NSMutableArray *)_fy_UIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, _cmd);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end

//
//  UIControl+FYExt.m
//  FYCategories
//
//  Created by foyoodo on 2021/10/2.
//

#import "UIControl+FYExt.h"
#import <objc/runtime.h>

@interface _FYUIControlBlockTarget : NSObject

- (instancetype)initWithBlock:(void (^)(id sender))block forControlEvents:(UIControlEvents)events;
- (void)invoke:(id)sender;

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

@end

@implementation _FYUIControlBlockTarget

- (instancetype)initWithBlock:(void (^)(id))block forControlEvents:(UIControlEvents)events {
    if (self = [super init]) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    !_block ?: _block(sender);
}

@end

@implementation UIControl (FYExt)

- (instancetype)initWithActionBlock:(void (^)(id _Nonnull))block forControlEvents:(UIControlEvents)events {
    if (self = [self init]) {
        [self addActionBlock:block forControlEvents:events];
    }
    return self;
}

- (void)addActionBlock:(void (^)(id sender))block forControlEvents:(UIControlEvents)events {
    _FYUIControlBlockTarget *target = [[_FYUIControlBlockTarget alloc] initWithBlock:block forControlEvents:events];
    [self addTarget:target action:@selector(invoke:) forControlEvents:events];
    NSMutableArray *targets = [self _fy_UIControlBlockTargets];
    [targets addObject:target];
}

- (NSMutableArray *)_fy_UIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, _cmd);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end

//
//  NSTimer+MAExt.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/15.
//

#import "NSTimer+MAExt.h"

@interface WeakTarget : NSObject

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation WeakTarget

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo {
    WeakTarget *weakTarget = [WeakTarget new];
    weakTarget.target = aTarget;
    weakTarget.selector = aSelector;
    weakTarget.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:weakTarget selector:@selector(fire:) userInfo:nil repeats:yesOrNo];
    return weakTarget.timer;
}

- (void)fire:(NSTimer *)timer {
    if (_target) {
        ((void (*)(id, SEL))[_target methodForSelector:_selector])(_target, _selector);
    } else {
        [_timer invalidate];
    }
}

@end

@implementation NSTimer(MAExt)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo {
    return [WeakTarget scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector repeats:yesOrNo];
}

@end

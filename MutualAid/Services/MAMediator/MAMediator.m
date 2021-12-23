//
//  MAMediator.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import "MAMediator.h"
#import <CTMediator/CTMediator.h>

@interface MAMediator ()

@property (nonatomic, weak, readonly) CTMediator *sharedMediator;

@end

@implementation MAMediator

+ (instancetype)sharedInstance {
    static MAMediator *mediator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[MAMediator alloc] init];
    });
    return mediator;
}

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary * _Nullable))completion {
    return [self.sharedMediator performActionWithUrl:url completion:completion];
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)cache {
    return [self.sharedMediator performTarget:targetName action:actionName params:params shouldCacheTarget:cache];
}

- (void)releaseCachedTargetWithFullTargetName:(NSString *)fullTargetName {
    [self.sharedMediator releaseCachedTargetWithFullTargetName:fullTargetName];
}

- (CTMediator *)sharedMediator {
    return [CTMediator sharedInstance];
}

@end

//
//  MAMediator.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAMediator : NSObject

+ (instancetype)sharedInstance;

- (nullable id)performActionWithUrl:(nullable NSURL *)url completion:(void (^_Nullable)(NSDictionary * _Nullable info))completion;

- (nullable id)performTarget:(nullable NSString *)targetName action:(nullable NSString *)actionName params:(nullable NSDictionary *)params shouldCacheTarget:(BOOL)cache;

- (void)releaseCachedTargetWithFullTargetName:(nullable NSString *)fullTargetName;

@end

NS_ASSUME_NONNULL_END

//
//  MALoginHelper.h
//  MutualAid
//
//  Created by foyoodo on 2022/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kMALoginUserInfoKeyPhone;
extern NSString * const kMALoginUserInfoKeyUsername;
extern NSString * const kMALoginUserInfoKeyPassword;

typedef NS_ENUM(NSUInteger, MALoginType) {
    MALoginTypePhone,
    MALoginTypeUsername
};

typedef void(^MALoginCompletionBlock)(void);

@interface MALoginHelper : NSObject

+ (instancetype)defaultHelper;

- (void)loginWithType:(MALoginType)type userInfo:(nullable NSDictionary *)userInfo completion:(nullable MALoginCompletionBlock)completion;

- (void)logoutWithCompletion:(void (^ _Nullable)(void))completion;

@property (nonatomic, readonly, assign) BOOL isLogin;

@end

NS_ASSUME_NONNULL_END

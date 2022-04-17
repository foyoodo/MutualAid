//
//  MALoginHelper.m
//  MutualAid
//
//  Created by foyoodo on 2022/4/16.
//

#import "MALoginHelper.h"

NSString * const kMALoginUserInfoKeyPhone    = @"phone";
NSString * const kMALoginUserInfoKeyUsername = @"username";
NSString * const kMALoginUserInfoKeyPassword = @"password";

typedef NS_ENUM(NSUInteger, MALoginErrorType) {
    MALoginErrorTypeDefault,
    MALoginErrorTypeUsername,
    MALoginErrorTypePassword
};

@implementation MALoginHelper

#pragma mark - Public Methods

+ (instancetype)defaultHelper {
    static MALoginHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[MALoginHelper alloc] init];
    });
    return helper;
}

- (BOOL)isLogin {
    return [MAUserDefaults standardUserDefaults].userId != nil;
}

- (void)loginWithType:(MALoginType)type userInfo:(nullable NSDictionary *)userInfo completion:(nullable MALoginCompletionBlock)completion {
    switch (type) {
        case MALoginTypePhone: {
            [self loginByPhoneWithUserInfo:userInfo completion:completion];
        } break;

        case MALoginTypeUsername: {
            [self loginByUsernameWithUserInfo:userInfo completion:completion];
        } break;
    }
}

#pragma mark - Login Type

- (void)loginByUsernameWithUserInfo:(NSDictionary *)userInfo completion:(MALoginCompletionBlock)completion {
    NSString *username = userInfo[kMALoginUserInfoKeyUsername];
    NSString *password = userInfo[kMALoginUserInfoKeyPassword];

    if (!username) {
        [self loginFailedWithErrorType:MALoginErrorTypeUsername];
        return;
    }

    if (!password) {
        [self loginFailedWithErrorType:MALoginErrorTypePassword];
        return;
    }

    [MAUserDefaults standardUserDefaults].userPicUrl = @"https://lh3.googleusercontent.com/ogw/ADea4I6KMpBrLiKnhOyNOe_fmE3PmnHu9UclRR9ND9bD=s192-c-mo";
    [MAUserDefaults standardUserDefaults].userName = username;
    [MAUserDefaults standardUserDefaults].userId = [NSNumber numberWithUnsignedInteger:username.hash];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kMAUserLoginStateChangedNotification object:nil userInfo:@{
            @"isLogin": @YES
        }];

        !completion ?: completion();
    });
}

- (void)loginByPhoneWithUserInfo:(NSDictionary *)userInfo completion:(MALoginCompletionBlock)completion {
    NSString *phone = userInfo[kMALoginUserInfoKeyPhone];
    NSString *password = userInfo[kMALoginUserInfoKeyPassword];

    if (!phone) {
        [self loginFailedWithErrorType:MALoginErrorTypeUsername];
        return;
    }

    if (!password) {
        [self loginFailedWithErrorType:MALoginErrorTypePassword];
        return;
    }

    !completion ?: completion();
}

#pragma mark - Login Failed

- (void)loginFailedWithErrorType:(MALoginErrorType)errorType {
    switch (errorType) {
        case MALoginErrorTypeDefault: {
            NSLog(@"default error");
        } break;

        case MALoginErrorTypeUsername: {
            NSLog(@"username error");
        } break;

        case MALoginErrorTypePassword: {
            NSLog(@"password error");
        } break;
    }
}

#pragma mark - Logout

- (void)logoutWithCompletion:(void (^)(void))completion {
    if (!self.isLogin) {
        return;
    }

    [MAUserDefaults standardUserDefaults].userId = nil;
    [MAUserDefaults standardUserDefaults].userName = @"未登录";
    [MAUserDefaults standardUserDefaults].userPicUrl = nil;

    [[NSNotificationCenter defaultCenter] postNotificationName:kMAUserLoginStateChangedNotification object:nil userInfo:@{
        @"isLogin": @NO
    }];

    !completion ?: completion();
}

@end

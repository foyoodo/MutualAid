//
//  MAUserDefaults.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/3.
//

#import "MAUserDefaults.h"

NSString * const kMAUserLoginStateChangedNotification = @"kMAUserLoginStateChangedNotification";

@implementation MAUserDefaults

@dynamic userId;
@dynamic userName;
@dynamic userPicUrl;

- (NSDictionary *)setupDefaults {
    return @{
        @"userId": @0,
        @"userName": @"未登录",
        @"userPicUrl": @""
    };
}

@end

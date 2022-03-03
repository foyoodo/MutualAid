//
//  MAUserDefaults.h
//  MutualAid
//
//  Created by foyoodo on 2022/3/3.
//

#import "GVUserDefaults.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAUserDefaults : GVUserDefaults

@property (nonatomic, weak) NSNumber *userId;
@property (nonatomic, weak) NSString *userName;
@property (nonatomic, weak) NSString *userPicUrl;

@end

NS_ASSUME_NONNULL_END

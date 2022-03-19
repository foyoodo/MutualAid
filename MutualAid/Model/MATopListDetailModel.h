//
//  MATopListDetailModel.h
//  MutualAid
//
//  Created by foyoodo on 2022/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MATopListDetailModel : NSObject

+ (instancetype)modelWithPlayerUrl:(nullable NSString *)playerUrl webPageUrl:(nullable NSString *)webPageUrl;

- (instancetype)initWithPlayerUrl:(nullable NSString *)playerUrl webPageUrl:(nullable NSString *)webPageUrl;

@property (nonatomic, readonly, copy) NSString *playerUrl;
@property (nonatomic, readonly, copy) NSString *webPageUrl;

@end

NS_ASSUME_NONNULL_END

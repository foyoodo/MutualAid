//
//  MATopListDetailModel.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/19.
//

#import "MATopListDetailModel.h"

@implementation MATopListDetailModel

+ (instancetype)modelWithPlayerUrl:(NSString *)playerUrl webPageUrl:(NSString *)webPageUrl {
    return [[self alloc] initWithPlayerUrl:playerUrl webPageUrl:webPageUrl];
}

- (instancetype)init {
    return [self initWithPlayerUrl:nil webPageUrl:nil];
}

- (instancetype)initWithPlayerUrl:(NSString *)playerUrl webPageUrl:(NSString *)webPageUrl {
    if (self = [super init]) {
        _playerUrl = playerUrl;
        _webPageUrl = webPageUrl;
    }
    return self;
}

@end

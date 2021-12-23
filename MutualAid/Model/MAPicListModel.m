//
//  MAPicListModel.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/10.
//

#import "MAPicListModel.h"

@implementation MAPicListModel

+ (instancetype)modelWithTitle:(NSString *)title picUrl:(NSString *)picUrl {
    return [self modelWithTitle:title picUrl:picUrl jumpUrl:nil];
}

+ (instancetype)modelWithTitle:(NSString *)title picUrl:(NSString *)picUrl jumpUrl:(NSString *)jumpUrl {
    return [[self alloc] initWithTitle:title picUrl:picUrl jumpUrl:jumpUrl];
}

- (instancetype)initWithTitle:(NSString *)title picUrl:(NSString *)picUrl {
    return [self initWithTitle:title picUrl:picUrl jumpUrl:nil];
}

- (instancetype)initWithTitle:(NSString *)title picUrl:(NSString *)picUrl jumpUrl:(NSString *)jumpUrl {
    if (self = [super init]) {
        _title = title;
        _picUrl = picUrl;
        _jumpUrl = jumpUrl;
    }
    return self;
}

@end

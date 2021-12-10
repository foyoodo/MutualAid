//
//  MAPicListModel.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/10.
//

#import "MAPicListModel.h"

@implementation MAPicListModel

+ (instancetype)modelWithTitle:(NSString *)title picUrl:(NSString *)picUrl {
    return [[self alloc] initWithTitle:title picUrl:picUrl];
}

- (instancetype)initWithTitle:(NSString *)title picUrl:(NSString *)picUrl {
    if (self = [super init]) {
        _title = title;
        _picUrl = picUrl;
    }
    return self;
}

@end

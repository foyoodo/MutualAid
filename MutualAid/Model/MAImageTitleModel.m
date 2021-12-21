//
//  MAImageTitleModel.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/21.
//

#import "MAImageTitleModel.h"

@implementation MAImageTitleModel

#pragma mark - Init Methods

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    if (self = [super init]) {
        _image = image;
        _title = title;
    }
    return self;
}

@end

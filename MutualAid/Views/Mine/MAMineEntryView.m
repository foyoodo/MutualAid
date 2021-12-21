//
//  MAMineEntryView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/21.
//

#import "MAMineEntryView.h"

@implementation MAMineEntryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:(_imageView = imageView)];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
            make.centerX.equalTo(self);
            make.width.height.equalTo(@(28));
        }];

        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(8);
            make.centerX.equalTo(imageView);
            make.bottom.equalTo(self).offset(-8);
        }];
    }
    return self;
}

@end

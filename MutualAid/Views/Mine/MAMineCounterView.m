//
//  MAMineCounterView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/21.
//

#import "MAMineCounterView.h"

@implementation MAMineCounterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *countLabel = [UILabel new];
        countLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        [self addSubview:(_countLabel = countLabel)];
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
            make.centerX.equalTo(self);
        }];

        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(countLabel.mas_bottom).offset(8);
            make.bottom.equalTo(self).offset(-8);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

@end

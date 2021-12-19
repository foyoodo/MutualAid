//
//  MASectionHeaderView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import "MASectionHeaderView.h"

@implementation MASectionHeaderView

#pragma mark - Init Methods

- (instancetype)init {
    return [self initWithTitle:@""];
}

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.backgroundColor = [UIColor systemGroupedBackgroundColor];

        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        titleLabel.text = title;
        [self addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.bottom.equalTo(self).offset(-6);
        }];
    }
    return self;
}

#pragma mark - Public Methods

+ (CGFloat)height {
    return 40;
}

- (CGFloat)paddingLeft {
    return 0;
}

- (void)setPaddingLeft:(CGFloat)paddingLeft {
    if (paddingLeft >= 0) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(paddingLeft);
        }];
    }
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end

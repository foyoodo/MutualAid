//
//  MASectionHeaderView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import "MASectionHeaderView.h"

@interface MASectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

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
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(20);
        }];
    }
    return self;
}

#pragma mark - Public Methods

+ (CGFloat)height {
    return 32;
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end

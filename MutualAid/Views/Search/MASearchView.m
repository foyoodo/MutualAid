//
//  MASearchView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import "MASearchView.h"

@implementation MASearchView

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = self.backgroundColor.CGColor;
        self.layer.borderWidth = 1.0;

        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageWithSymbol:@"magnifyingglass"]];
        [self addSubview:(_icon = icon)];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(120);
            make.width.height.equalTo(@(20));
        }];

        UITextField *textField = [UITextField new];
        textField.userInteractionEnabled = NO;
        [self addSubview:(_textField = textField)];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(8);
            make.right.equalTo(self).offset(-12);
        }];

        textField.placeholder = @"Search".localized;
    }
    return self;
}

#pragma mark - Public Methods

- (void)prepareForTransitionIfShow:(BOOL)show {
    [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
        if (show) {
            make.left.equalTo(self).offset(12);
        } else {
            make.left.equalTo(self).offset(120);
        }
    }];
}

@end

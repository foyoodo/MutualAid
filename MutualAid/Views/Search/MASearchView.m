//
//  MASearchView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import "MASearchView.h"

@interface MASearchView ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) MASConstraint *containerViewHorizontalConstraint;

@end

@implementation MASearchView

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = self.backgroundColor.CGColor;
        self.layer.borderWidth = 1.0;

        UIView *containerView = [UIView new];
        [self addSubview:(_containerView = containerView)];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.centerY.equalTo(self);
            self.containerViewHorizontalConstraint = make.centerX.equalTo(self);
        }];

        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageWithSymbol:@"magnifyingglass"]];
        [containerView addSubview:(_icon = icon)];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(containerView);
            make.left.equalTo(containerView).offset(12);
            make.bottom.lessThanOrEqualTo(containerView);
            make.width.height.equalTo(@(20));
            make.centerY.equalTo(containerView);
        }];

        UITextField *textField = [UITextField new];
        [containerView addSubview:(_textField = textField)];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(containerView);
            make.left.equalTo(icon.mas_right).offset(8);
            make.right.equalTo(containerView).offset(-12);
            make.bottom.lessThanOrEqualTo(containerView);
            make.centerY.equalTo(icon);
        }];

        self.textFieldUserInteractionEnabled = NO;

        textField.placeholder = @"Search".localized;
    }
    return self;
}

#pragma mark - Public Methods

- (void)prepareForTransitionIfShow:(BOOL)show {
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        [self.containerViewHorizontalConstraint uninstall];
        if (show) {
            self.containerViewHorizontalConstraint = make.left.right.equalTo(self);
        } else {
            self.containerViewHorizontalConstraint = make.centerX.equalTo(self);
        }
    }];
}

#pragma mark - Getter & Setter

- (BOOL)textFieldUserInteractionEnabled {
    return self.containerView.userInteractionEnabled && self.textField.userInteractionEnabled;
}

- (void)setTextFieldUserInteractionEnabled:(BOOL)enabled {
    self.containerView.userInteractionEnabled = enabled;
    self.textField.userInteractionEnabled = enabled;
}

@end

//
//  MALoginInputView.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/2.
//

#import "MALoginInputView.h"

const CGFloat kLoginInputViewCornerRadius = 12;

@interface MALoginInputView ()

@property (nonatomic, strong) UITextField *uidTextField;
@property (nonatomic, strong) UITextField *pwdTextField;

@end

@implementation MALoginInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupUI {
    UITextField *uidTextField = [UITextField new];
    uidTextField.layer.borderWidth = 1;
    uidTextField.layer.cornerRadius = kLoginInputViewCornerRadius;
    uidTextField.layer.borderColor = [UIColor colorNamed:@"AccentColor"].CGColor;
    uidTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLoginInputViewCornerRadius, 0)];
    uidTextField.leftViewMode = UITextFieldViewModeAlways;
    uidTextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLoginInputViewCornerRadius, 0)];
    uidTextField.rightViewMode = UITextFieldViewModeAlways;
    uidTextField.placeholder = @"userid".localized;
    [self addSubview:(_uidTextField = uidTextField)];
    [uidTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(40));
    }];
    RAC(uidTextField.layer, borderColor) = [[uidTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length >= 3);
    }] map:^id _Nullable(id _Nullable value) {
        return [value boolValue] ? (__bridge id)[UIColor colorNamed:@"AccentColor"].CGColor : (__bridge id)[UIColor systemRedColor].CGColor;
    }];

    UITextField *pwdTextField = [UITextField new];
    pwdTextField.layer.borderWidth = 1;
    pwdTextField.layer.cornerRadius = kLoginInputViewCornerRadius;
    pwdTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLoginInputViewCornerRadius, 0)];
    pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    pwdTextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLoginInputViewCornerRadius, 0)];
    pwdTextField.rightViewMode = UITextFieldViewModeAlways;
    pwdTextField.returnKeyType = UIReturnKeyGo;
    pwdTextField.secureTextEntry = YES;
    pwdTextField.placeholder = @"password".localized;
    [self addSubview:(_pwdTextField = pwdTextField)];
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uidTextField.mas_bottom).offset(20);
        make.left.right.height.equalTo(uidTextField);
        make.bottom.equalTo(self.mas_bottom);
    }];
    RAC(pwdTextField.layer, borderColor) = [[pwdTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length >= 5);
    }] map:^id _Nullable(id _Nullable value) {
        return [value boolValue] ? (__bridge id)[UIColor colorNamed:@"AccentColor"].CGColor : (__bridge id)[UIColor systemRedColor].CGColor;
    }];
}

#pragma mark - Public Methods

- (void)showKeyboard {
    [self.uidTextField becomeFirstResponder];
}

- (void)hideKeyboard {
    [self.uidTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

@end

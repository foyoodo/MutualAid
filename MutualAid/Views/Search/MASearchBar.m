//
//  MASearchBar.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import "MASearchBar.h"

@interface MASearchBar ()

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) MASConstraint *searchViewHorizontalConstraint;

@end

@implementation MASearchBar

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];

        MASearchView *searchView = [MASearchView new];
        searchView.layer.cornerRadius = 18;
        [self addSubview:(_searchView = searchView)];
        [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(12);
            make.left.equalTo(self).offset(12);
            self.searchViewHorizontalConstraint = make.right.equalTo(self).offset(-12);
            make.bottom.equalTo(self).offset(-8);
            make.height.equalTo(@(36));
        }];
        [searchView addTarget:self action:@selector(searchViewDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - Public Methods

- (void)prepareForTransition {
    self.searchView.layer.borderColor = [UIColor accentColor].CGColor;
    [self.searchView prepareForTransitionIfShow:YES];
    [self.searchView mas_updateConstraints:^(MASConstraintMaker *make) {
        [self.searchViewHorizontalConstraint uninstall];
        self.searchViewHorizontalConstraint = make.right.equalTo(self.cancelButton.mas_left).offset(-4);
    }];
    [self layoutIfNeeded];
}

- (CGFloat)height {
    return 12 + 36 + 8;
}

#pragma mark - Private Mehtods

- (void)searchViewDidClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidClick)]) {
        [self.delegate searchBarDidClick];
    }
}

- (void)cancelButtonDidClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidCancel)]) {
        [self.delegate searchBarDidCancel];
    }
}

#pragma mark - Lazy Load

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        [_cancelButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Cancel".localized attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:13],
            NSForegroundColorAttributeName: [UIColor grayColor]
        }] forState:UIControlStateNormal];
        [self addSubview:_cancelButton];
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searchView);
            make.right.equalTo(self).offset(-8);
            make.width.equalTo(@(44));
            make.height.equalTo(self.searchView);
        }];
        [_cancelButton addTarget:self action:@selector(cancelButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

#pragma mark - Getter & Setter

- (UITextField *)textField {
    return self.searchView.textField;
}

@end

//
//  MALoginViewController.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/2.
//

#import "MALoginViewController.h"
#import "MALoginInputView.h"

static const NSTimeInterval kAnimationDuration = 0.3;

@interface MALoginViewController ()

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *changeLoginButton;

@property (nonatomic, strong) MALoginInputView *uidLoginIputView;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) MASConstraint *containerViewVerticalConstraint;

@end

@implementation MALoginViewController

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupActions];

    self.title = @"Login".localized;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        [self.containerViewVerticalConstraint uninstall];
        self.containerViewVerticalConstraint = make.bottom.equalTo(self.view);
    }];
    [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
        [self.uidLoginIputView showKeyboard];
        [self.maskView setAlpha:0.6];
    } completion:nil];
}

- (void)setupUI {
    UIView *maskView = [UIView new];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [self.view addSubview:(_maskView = maskView)];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 12;
    containerView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [self.view addSubview:(_containerView = containerView)];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.containerViewVerticalConstraint = make.top.equalTo(self.view.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.8);
    }];

    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"用户登录";
    titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    [containerView addSubview:(_titleLabel = titleLabel)];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(containerView).offset(40);
    }];

    [containerView addSubview:self.uidLoginIputView];
    [self.uidLoginIputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(40);
        make.left.equalTo(titleLabel);
        make.right.equalTo(containerView).offset(-40);
    }];

    UIButton *loginButton = [UIButton new];
    loginButton.layer.cornerRadius = kLoginInputViewCornerRadius;
    loginButton.backgroundColor = [UIColor colorNamed:@"AccentColor"];
    loginButton.tintColor = [UIColor whiteColor];
    [loginButton setTitle:@"Login".localized forState:UIControlStateNormal];
    [containerView addSubview:(_loginButton = loginButton)];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.uidLoginIputView.mas_bottom).offset(20);
        make.right.equalTo(self.uidLoginIputView);
        make.width.equalTo(@(90));
        make.height.equalTo(@(40));
    }];

    UIButton *changeLoginButton = [UIButton new];
    [changeLoginButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"使用手机号登录" attributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:12],
        NSForegroundColorAttributeName: [UIColor colorNamed:@"AccentColor"]
    }] forState:UIControlStateNormal];
    [changeLoginButton sizeToFit];
    [containerView addSubview:(_changeLoginButton = changeLoginButton)];
    [changeLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-40);
        make.bottom.equalTo(titleLabel);
    }];
}

- (void)setupActions {
    @weakify(self)
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id _Nonnull sender) {
        @strongify(self)
        [self dismissWithCompletion:nil];
    }]];
    [self.loginButton addActionBlock:^(id _Nonnull sender) {
        [MAUserDefaults standardUserDefaults].userPicUrl = @"https://lh3.googleusercontent.com/ogw/ADea4I6KMpBrLiKnhOyNOe_fmE3PmnHu9UclRR9ND9bD=s192-c-mo";
        [MAUserDefaults standardUserDefaults].userName = @"foyoodo";
        @strongify(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissWithCompletion:^{
                !self.loginSucceedBlock ?: self.loginSucceedBlock();
            }];
        });
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissWithCompletion:(void (^)(void))completion {
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        [self.containerViewVerticalConstraint uninstall];
        self.containerViewVerticalConstraint = make.top.equalTo(self.view.mas_bottom);
    }];
    [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
        [self.uidLoginIputView hideKeyboard];
        [self.maskView setAlpha:0];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:completion];
    }];
}

#pragma mark - Lazy Load

- (MALoginInputView *)uidLoginIputView {
    if (!_uidLoginIputView) {
        _uidLoginIputView = [[MALoginInputView alloc] init];
    }
    return _uidLoginIputView;
}

@end

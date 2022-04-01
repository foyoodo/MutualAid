//
//  MAMapPanView.m
//  MutualAid
//
//  Created by foyoodo on 2022/4/1.
//

#import "MAMapPanView.h"
#import "MASearchBar.h"
#import "MAMineEntryView.h"

@interface MAMapPanView ()

@property (nonatomic, strong) UIStackView *entryStackView;

@end

@implementation MAMapPanView {
    CGFloat _tabBarHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.entryStackView];

        NSArray<UIImage *> *imageArray = @[
            [UIImage systemImageNamed:@"location.circle"],
            [UIImage systemImageNamed:@"pencil.circle"],
            [UIImage systemImageNamed:@"flag.circle"],
            [UIImage systemImageNamed:@"flame.circle"]
        ];
        NSArray<NSString *> *titleArray = @[
            @"最近AED",
            @"志愿者申请",
            @"公益活动",
            @"赛事活动"
        ];

        @weakify(self)
        for (NSInteger i = 0; i < imageArray.count; ++i) {
            MAMineEntryView *entryView = [MAMineEntryView new];
            entryView.imageView.image = [imageArray objectAtIndex:i];
            entryView.titleLabel.text = [titleArray objectAtIndex:i];
            [self.entryStackView addArrangedSubview:entryView];
            if (i == 0) {
                [self.entryStackView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@([entryView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height));
                }];
            }
            [entryView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id _Nonnull sender) {
                @strongify(self)
                if (i == 0) {

                } else {
                    [MAToast showMessage:@"该功能暂未开放，敬请期待..." inView:self.viewController.view];
                }
            }]];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.entryStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
}

#pragma mark - HWPanModalPresentable

- (void)presentedViewDidMoveToSuperView {
    _tabBarHeight = self.viewController.tabBarController.tabBar.frame.size.height;
}

- (PanModalHeight)shortFormHeight {
    return PanModalHeightMake(PanModalHeightTypeContentIgnoringSafeArea, _tabBarHeight + 160);
}

- (PanModalHeight)longFormHeight {
    return PanModalHeightMake(PanModalHeightTypeMaxTopInset, 240);
}

- (HWBackgroundConfig *)backgroundConfig {
    HWBackgroundConfig *config = [HWBackgroundConfig new];
    config.backgroundAlpha = 0;
    return config;
}

- (CGFloat)cornerRadius {
    return 16.0;
}

- (BOOL)allowsTapBackgroundToDismiss {
    return NO;
}

- (BOOL)allowsDragToDismiss {
    return NO;
}

- (BOOL)allowsTouchEventsPassingThroughTransitionView {
    return YES;
}

#pragma mark - Getter & Setter

- (UIStackView *)entryStackView {
    if (!_entryStackView) {
        _entryStackView = [UIStackView new];
        _entryStackView.distribution = UIStackViewDistributionFillEqually;
        _entryStackView.spacing = 10;
    }
    return _entryStackView;
}

@end

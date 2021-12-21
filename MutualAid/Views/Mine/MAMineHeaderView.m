//
//  MAMineHeaderView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/20.
//

#import "MAMineHeaderView.h"
#import "MAMineActivityBanner.h"
#import "MAMineCounterView.h"
#import "MAMineEntryView.h"

@interface MAMineHeaderView ()

@property (nonatomic, strong) UIStackView *counterStackView;
@property (nonatomic, strong) UIStackView *entryStackView;
@property (nonatomic, strong) MAMineActivityBanner *activityBanner;

@end

@implementation MAMineHeaderView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIStackView *counterStackView = [UIStackView new];
        counterStackView.distribution = UIStackViewDistributionFillEqually;
        counterStackView.alignment = UIStackViewAlignmentFill;
        counterStackView.spacing = 10;
        [self addSubview:(_counterStackView = counterStackView)];
        [counterStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@(50));
        }];

        UIStackView *entryStackView = [UIStackView new];
        entryStackView.distribution = UIStackViewDistributionFillEqually;
        entryStackView.spacing = 10;
        [self addSubview:(_entryStackView = entryStackView)];
        [entryStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(counterStackView.mas_bottom).offset(10);
            make.left.right.equalTo(counterStackView);
            make.height.equalTo(@(60));
        }];

        MAMineActivityBanner *activityBanner = [MAMineActivityBanner new];
        [self addSubview:(_activityBanner = activityBanner)];
        [activityBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(entryStackView.mas_bottom).offset(20);
            make.left.right.equalTo(counterStackView);
            make.bottom.equalTo(self).offset(-10);
            make.height.equalTo(@(70));
        }];

        [self setupStackView];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupStackView {
    NSArray<NSString *> *counterTitleArray = @[
        @"我的证书",
        @"我的活动",
        @"我的勋章"
    ];
    for (NSInteger i = 0; i < counterTitleArray.count; ++i) {
        MAMineCounterView *counterView = [MAMineCounterView new];
        counterView.countLabel.text = [NSString stringWithFormat:@"%zd", i];
        counterView.titleLabel.text = [counterTitleArray objectAtIndex:i];
        [self.counterStackView addArrangedSubview:counterView];
        if (i == 0) {
            [self.counterStackView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([counterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height));
            }];
        }
    }

    NSArray<UIImage *> *imageArray = @[
        [UIImage systemImageNamed:@"icloud.and.arrow.down"],
        [UIImage systemImageNamed:@"arrow.counterclockwise.circle"],
        [UIImage systemImageNamed:@"star"],
        [UIImage systemImageNamed:@"arrow.clockwise.circle"]
    ];
    NSArray<NSString *> *titleArray = @[
        @"离线缓存",
        @"历史记录",
        @"我的收藏",
        @"稍后再看"
    ];

    for (NSInteger i = 0; i < imageArray.count; ++i) {
        MAMineEntryView *entryView = [MAMineEntryView new];
        entryView.imageView.image = [imageArray objectAtIndex:i];
        entryView.titleLabel.text = [titleArray objectAtIndex:i];
        [self.entryStackView addArrangedSubview:entryView];
        if (i == 0) {
            [self.entryStackView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([entryView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height));
            }];
        }
    }
}

@end

//
//  MAMineHeaderView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/20.
//

#import "MAMineHeaderView.h"
#import "MAMineActivityBanner.h"

@interface MAMineHeaderView ()

@property (nonatomic, strong) UIView *topContainerView;
@property (nonatomic, strong) MAMineActivityBanner *activityBanner;

@end

@implementation MAMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *topContainerView = [UIView new];
        [self addSubview:_topContainerView = topContainerView];
        [topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(100));
        }];

        MAMineActivityBanner *activityBanner = [MAMineActivityBanner new];
        [self addSubview:(_activityBanner = activityBanner)];
        [activityBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topContainerView.mas_bottom).offset(10);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    return self;
}

@end

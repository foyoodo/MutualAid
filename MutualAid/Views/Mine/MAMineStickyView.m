//
//  MAMineStickyView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/19.
//

#import "MAMineStickyView.h"

@interface MAMineStickyView ()

@property (nonatomic, strong) UIImageView *avatorImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MAMineStickyView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor systemGroupedBackgroundColor];

        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 2);

        UIImageView *avatorImageView = [UIImageView new];
        avatorImageView.layer.masksToBounds = YES;
        [self addSubview:(_avatorImageView = avatorImageView)];
        [avatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(8);
            make.bottom.equalTo(self).offset(-8);
            make.width.equalTo(avatorImageView.mas_height);
        }];

        UILabel *nameLabel = [UILabel new];
        nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        nameLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:(_nameLabel = nameLabel)];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatorImageView.mas_right).offset(8);
            make.right.lessThanOrEqualTo(self).offset(-8);
            make.centerY.equalTo(avatorImageView);
        }];

        [avatorImageView sd_setImageWithURL:[NSURL URLWithString:@"https://lh3.googleusercontent.com/ogw/ADea4I6KMpBrLiKnhOyNOe_fmE3PmnHu9UclRR9ND9bD=s192-c-mo"]];
        nameLabel.text = @"foyoodo";
    }
    return self;
}

#pragma mark - Life Cycle

- (void)layoutSubviews {
    [super layoutSubviews];

    self.avatorImageView.layer.cornerRadius = self.avatorImageView.bounds.size.width / 2;
}

@end

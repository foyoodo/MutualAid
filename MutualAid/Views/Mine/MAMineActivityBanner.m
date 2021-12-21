//
//  MAMineActivityBanner.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/20.
//

#import "MAMineActivityBanner.h"

@interface MAMineActivityBanner ()

@property (nonatomic, strong) UIView *leftContainerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) MASConstraint *titleLabelHorizontalConstraint;
@end

@implementation MAMineActivityBanner

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.layer.borderColor = [UIColor colorNamed:@"AccentColor"].CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 6;

        UIView *leftContainerView = [UIView new];
        [self addSubview:(_leftContainerView = leftContainerView)];
        [leftContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(self);
        }];

        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [self.leftContainerView addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftContainerView);
            self.titleLabelHorizontalConstraint = make.left.equalTo(self.leftContainerView);
            make.right.lessThanOrEqualTo(self.leftContainerView);
            make.bottom.lessThanOrEqualTo(self.leftContainerView);
        }];

        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor colorNamed:@"AccentColor"];
        button.layer.cornerRadius = 16;
        button.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
        button.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        button.titleLabel.textColor = [UIColor whiteColor];
        button.tintColor = [UIColor whiteColor];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        button.adjustsImageWhenHighlighted = NO;
        [self addSubview:(_button = button)];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(leftContainerView);
            make.width.equalTo(button.mas_height).multipliedBy(3);
            make.height.equalTo(@(32));
        }];

        self.imageView.image = [UIImage systemImageNamed:@"books.vertical"];
        self.titleLabel.text = @"报名参与线上课程培训";
        self.descLabel.text = @"现在报名学习可获赠纪念品一份";
        [self.button setImage:[UIImage systemImageNamed:@"hand.point.up" withConfiguration:[UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightMedium]] forState:UIControlStateNormal];
        [self.button setTitle:@"立即报名" forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - Lazy Load

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self.leftContainerView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftContainerView);
            make.centerY.equalTo(self.titleLabel);
            make.height.equalTo(self.titleLabel.mas_height);
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            [self.titleLabelHorizontalConstraint uninstall];
            self.titleLabelHorizontalConstraint = make.left.equalTo(_imageView.mas_right).offset(4);
        }];
    }
    return _imageView;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.textColor = [UIColor lightGrayColor];
        [self.leftContainerView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
            make.left.equalTo(self.leftContainerView);
            make.right.lessThanOrEqualTo(self.leftContainerView);
            make.bottom.equalTo(self.leftContainerView);
        }];
    }
    return _descLabel;
}

@end

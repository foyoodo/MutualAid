//
//  MATopListCollectionViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//

#import "MATopListCollectionViewCell.h"
#import "MAPicListModel.h"

@interface MATopListCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MATopListCollectionViewCell

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [UIImageView new];
        [self.contentView addSubview:(_imageView = imageView)];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(8);
            make.centerX.equalTo(self.contentView);
            make.width.height.equalTo(@(40));
        }];

        UILabel *titleLabel = [UILabel new];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(4);
            make.left.equalTo(self.contentView).offset(2);
            make.right.equalTo(self.contentView).offset(-2);
            make.height.equalTo(@(20));
        }];
    }
    return self;
}

#pragma mark - Public Methods

+ (CGSize)itemSize {
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 20 * 2 - 8 * 4) / 5;
    return CGSizeMake(width, 64 + 8 * 2);
}

- (void)setData:(MAPicListModel *)cellModel {
    self.titleLabel.text = cellModel.title;
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:cellModel.picUrl] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
}

@end

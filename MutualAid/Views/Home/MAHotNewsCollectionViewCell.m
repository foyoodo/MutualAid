//
//  MAHotNewsCollectionViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import "MAHotNewsCollectionViewCell.h"
#import "MAPicListModel.h"

@interface MAHotNewsCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MAHotNewsCollectionViewCell

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        UIImageView *imageView = [UIImageView new];
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:(_imageView = imageView)];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(12);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(imageView.mas_width).multipliedBy(0.5);
        }];

        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.numberOfLines = 2;
        [self.contentView addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(4);
            make.left.equalTo(imageView);
            make.right.lessThanOrEqualTo(imageView);
        }];
    }
    return self;
}

#pragma mark - Public Methods

+ (CGSize)itemSize {
    return CGSizeMake(160, 80 + 30 + 24);
}

- (void)setData:(MAPicListModel *)cellModel {
    [self.titleLabel setText:cellModel.title];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.picUrl]];
}

@end

//
//  MACycleBannerCollectionViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//

#import "MACycleBannerCollectionViewCell.h"
#import "MAPicListModel.h"

@interface MACycleBannerCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MACycleBannerCollectionViewCell

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = self.contentView.bounds;
        [self.contentView addSubview:(_imageView = imageView)];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setData:(MAPicListModel *)cellModel {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.picUrl]];
}

@end

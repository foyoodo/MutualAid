//
//  MASearchResultTableViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/1.
//

#import "MASearchResultTableViewCell.h"
#import "MAPicListModel.h"

@interface MASearchResultTableViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) MAPicListModel *cellModel;

@end

@implementation MASearchResultTableViewCell

@synthesize imageView = _imageView;

#pragma mark - Init Methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageView = [UIImageView new];
        imageView.layer.cornerRadius = 8;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:(_imageView = imageView)];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(8);
            make.bottom.equalTo(self.contentView).offset(-8);
            make.width.equalTo(imageView.mas_height).multipliedBy(2);
            make.height.equalTo(@(80));
        }];

        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [self.contentView addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView).offset(8);
            make.left.equalTo(imageView.mas_right).offset(8);
            make.right.lessThanOrEqualTo(self.contentView).offset(-8);
        }];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setData:(MAPicListModel *)cellModel {
    [self.titleLabel setText:cellModel.title];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.picUrl]];
}

@end

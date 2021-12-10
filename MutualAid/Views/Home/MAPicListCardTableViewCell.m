//
//  MAPicListCardTableViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/8.
//

#import "MAPicListCardTableViewCell.h"
#import "MAPicListModel.h"

@interface MAPicListCardTableViewCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) MAPicListModel *cellModel;

@end

@implementation MAPicListCardTableViewCell

@synthesize imageView = _imageView;

#pragma mark - Init Methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor systemGroupedBackgroundColor];

        UIView *containerView = [UIView new];
        containerView.backgroundColor = [UIColor whiteColor];
        containerView.layer.cornerRadius = 12;
        [self.contentView addSubview:(_containerView = containerView)];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(4);
            make.left.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView).offset(-12);
            make.bottom.equalTo(self.contentView).offset(-4);
        }];

        UIImageView *imageView = [UIImageView new];
        imageView.layer.cornerRadius = 8;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [containerView addSubview:(_imageView = imageView)];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(containerView).offset(8);
            make.bottom.equalTo(containerView).offset(-8);
            make.width.height.equalTo(@(80));
        }];

        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [containerView addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView).offset(8);
            make.left.equalTo(imageView.mas_right).offset(8);
            make.right.lessThanOrEqualTo(containerView);
        }];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setData:(MAPicListModel *)cellModel {
    [self.titleLabel setText:cellModel.title];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cellModel.picUrl]];
}

#pragma mark - Override

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];

    [UIView animateWithDuration:0.2 animations:^{
        if (highlighted) {
            self.containerView.backgroundColor = [UIColor systemGray5Color];
        } else {
            self.containerView.backgroundColor = [UIColor whiteColor];
        }
    }];
}

@end

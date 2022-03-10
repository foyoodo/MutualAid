//
//  MAPicListCardTableViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/8.
//

#import "MAPicListCardTableViewCell.h"
#import "MAPicListModel.h"

@interface MAPicListCardTableViewCell ()

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
        [self.contentView addSubview:(_containerView = containerView)];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView).offset(-12);
            make.bottom.equalTo(self.contentView).offset(-0.5);
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

        UIView *separatorView = [UIView new];
        separatorView.backgroundColor = [UIColor whiteColor];
        [containerView addSubview:(_separatorView = separatorView)];
        [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(containerView.mas_bottom);
            make.left.right.equalTo(containerView);
            make.height.equalTo(@(0.5));
        }];
        UIView *separatorLineView = [UIView new];
        separatorLineView.backgroundColor = [UIColor systemGray4Color];
        [separatorView addSubview:separatorLineView];
        [separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(separatorView);
            make.left.equalTo(titleLabel);
        }];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setData:(MAPicListModel *)cellModel {
    self.titleLabel.text = cellModel.title;
    self.imageView.yy_imageURL = [NSURL URLWithString:cellModel.picUrl];
}

#pragma mark - Override

- (void)prepareForReuse {
    [super prepareForReuse];

    self.containerView.layer.cornerRadius = 0;
    self.containerView.layer.maskedCorners = 0;

    self.separatorView.hidden = NO;
}

@end

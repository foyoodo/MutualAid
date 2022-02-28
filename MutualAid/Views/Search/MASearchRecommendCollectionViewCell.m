//
//  MASearchRecommendCollectionViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2022/2/27.
//

#import "MASearchRecommendCollectionViewCell.h"

@interface MASearchRecommendCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MASearchRecommendCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.layer.cornerRadius = 4;
        titleLabel.layer.masksToBounds = YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:(_titleLabel = titleLabel)];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark - Getter & Setter

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end

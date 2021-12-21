//
//  MAMineRecommendedServiceCollectionViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/21.
//

#import "MAMineRecommendedServiceCollectionViewCell.h"

@implementation MAMineRecommendedServiceCollectionViewCell

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MAMineEntryView *entryView = [MAMineEntryView new];
        [self.contentView addSubview:(_entryView = entryView)];
        [entryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end

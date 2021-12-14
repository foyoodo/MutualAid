//
//  MACycleBannerCollectionViewCell.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAPicListModel;

@interface MACycleBannerCollectionViewCell : UICollectionViewCell

- (void)setData:(MAPicListModel *)cellModel;

@end

NS_ASSUME_NONNULL_END

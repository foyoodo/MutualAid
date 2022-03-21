//
//  MACycleBannerView.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAPicListModel;

@interface MACycleBannerView : UIView

- (void)setData:(NSArray<MAPicListModel *> *)modelArray;

- (void)adjustPosition;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END

//
//  MAHotNewsCollectionViewCell.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAPicListModel;

@interface MAHotNewsCollectionViewCell : UICollectionViewCell

- (void)setData:(MAPicListModel *)cellModel;

@property (nonatomic, assign, class, readonly) CGSize itemSize;

@end

NS_ASSUME_NONNULL_END

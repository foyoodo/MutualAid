//
//  MAPicListCardTableViewCell.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAPicListModel;

@interface MAPicListCardTableViewCell : UITableViewCell

- (void)setData:(MAPicListModel *)cellModel;

@end

NS_ASSUME_NONNULL_END

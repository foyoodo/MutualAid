//
//  MASearchResultTableViewCell.h
//  MutualAid
//
//  Created by foyoodo on 2022/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAPicListModel;

@interface MASearchResultTableViewCell : UITableViewCell

- (void)setData:(MAPicListModel *)cellModel;

@end

NS_ASSUME_NONNULL_END

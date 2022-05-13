//
//  MAPicListViewController.h
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAPicListModel;

@interface MAPicListViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END

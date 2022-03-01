//
//  MASearchResultView.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MASearchResultView : UITableView

@property (nonatomic, copy) void (^didScrollBlock)(void);

@end

NS_ASSUME_NONNULL_END

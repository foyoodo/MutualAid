//
//  Target_Base.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_Base : NSObject

- (UIViewController *)Action_webViewController:(NSDictionary *)params;

- (UITableViewCell *)Action_cell:(NSDictionary *)params;

- (void)Action_configCell:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END

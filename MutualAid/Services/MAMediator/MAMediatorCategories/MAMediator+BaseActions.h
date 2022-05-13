//
//  MAMediator+BaseActions.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import "MAMediator.h"

NS_ASSUME_NONNULL_BEGIN

@class MAPicListModel;

@interface MAMediator (BaseActions)

- (UIViewController *)baseActions_webViewControllerWithTitle:(NSString *)title
                                                  requestURL:(NSURL *)requestURL
                                              detailListItem:(MAPicListModel *)detailListItem;

- (UITableViewCell *)baseActions_cellForTableView:(UITableView *)tableView
                                         withFont:(UIFont *)font
                                    andIdentifier:(NSString *)identifier;

- (void)baseActions_configTableViewCell:(UITableViewCell *)cell
                              withTitle:(NSString *)title
                               andImage:(UIImage *)image;

- (void)baseActions_cleanTableViewCellTarget;

@end

NS_ASSUME_NONNULL_END

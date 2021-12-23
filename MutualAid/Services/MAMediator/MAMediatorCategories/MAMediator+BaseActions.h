//
//  MAMediator+BaseActions.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import "MAMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAMediator (BaseActions)

- (UITableViewCell *)MAMediator_cellForTableView:(UITableView *)tableView
                                        withFont:(UIFont *)font
                                   andIdentifier:(NSString *)identifier;

- (void)MAMediator_configTableViewCell:(UITableViewCell *)cell
                             withTitle:(NSString *)title
                              andImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

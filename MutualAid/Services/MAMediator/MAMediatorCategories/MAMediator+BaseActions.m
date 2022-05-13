//
//  MAMediator+BaseActions.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import "MAMediator+BaseActions.h"

NSString * const kMAMediatorTargetBase = @"Base";

NSString * const kMAMediatorActionWebViewController = @"webViewController";
NSString * const kMAMediatorActionCell = @"cell";
NSString * const kMAMediatorActionConfigCell = @"configCell";

@implementation MAMediator (BaseActions)

- (UIViewController *)baseActions_webViewControllerWithTitle:(NSString *)title
                                                  requestURL:(NSURL *)requestURL
                                              detailListItem:(MAPicListModel *)detailListItem {
    return [self performTarget:kMAMediatorTargetBase
                        action:kMAMediatorActionWebViewController
                        params:@{ @"title": title, @"requestURL": requestURL, @"detailListItem": detailListItem }
             shouldCacheTarget:NO];
}

- (UITableViewCell *)baseActions_cellForTableView:(UITableView *)tableView
                                         withFont:(UIFont *)font
                                    andIdentifier:(NSString *)identifier {
    return [self performTarget:kMAMediatorTargetBase
                        action:kMAMediatorActionCell
                        params:@{ @"tableView": tableView, @"font": font, @"identifier": identifier }
             shouldCacheTarget:YES];
}

- (void)baseActions_configTableViewCell:(UITableViewCell *)cell
                              withTitle:(NSString *)title
                               andImage:(UIImage *)image {
    [self performTarget:kMAMediatorTargetBase
                 action:kMAMediatorActionConfigCell
                 params:@{ @"cell": cell, @"title": title, @"image": image }
      shouldCacheTarget:YES];
}

- (void)baseActions_cleanTableViewCellTarget {
    NSString *fullTargetName = [NSString stringWithFormat:@"Target_%@", kMAMediatorTargetBase];
    [self releaseCachedTargetWithFullTargetName:fullTargetName];
}

@end

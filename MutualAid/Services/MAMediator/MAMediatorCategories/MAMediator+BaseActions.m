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

- (UIViewController *)MAMediator_webViewControllerWithURL:(NSURL *)requestURL {
    return [self performTarget:kMAMediatorTargetBase action:kMAMediatorActionWebViewController params:@{ @"requestURL": requestURL } shouldCacheTarget:NO];
}

- (UITableViewCell *)MAMediator_cellForTableView:(UITableView *)tableView
                                        withFont:(UIFont *)font
                                   andIdentifier:(NSString *)identifier {
    return [self performTarget:kMAMediatorTargetBase
                        action:kMAMediatorActionCell
                        params:@{ @"tableView": tableView, @"font": font, @"identifier": identifier }
             shouldCacheTarget:YES];
}

- (void)MAMediator_configTableViewCell:(UITableViewCell *)cell
                             withTitle:(NSString *)title
                              andImage:(UIImage *)image {
    [self performTarget:kMAMediatorTargetBase
                 action:kMAMediatorActionConfigCell
                 params:@{ @"cell": cell, @"title": title, @"image": image }
      shouldCacheTarget:YES];
}

- (void)MAMediator_cleanTableViewCellTarget {
    NSString *fullTargetName = [NSString stringWithFormat:@"Target_%@", kMAMediatorTargetBase];
    [self releaseCachedTargetWithFullTargetName:fullTargetName];
}

@end

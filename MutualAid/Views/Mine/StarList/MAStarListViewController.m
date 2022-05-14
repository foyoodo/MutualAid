//
//  MAStarListViewController.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import "MAStarListViewController.h"
#import "MAListDataManager.h"

@interface MAStarListViewController ()

@end

@implementation MAStarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的收藏";

    [[MAListDataManager sharedManager].starList enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
        [self.dataArray addObject:obj];
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[MAListDataManager sharedManager] removeFromStarList:[self.dataArray objectAtIndex:indexPath.row]];
        [MAToast showMessage:@"取消收藏" inView:self.view];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end

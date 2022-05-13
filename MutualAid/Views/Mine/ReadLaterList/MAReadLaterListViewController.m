//
//  MAReadLaterListViewController.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import "MAReadLaterListViewController.h"
#import "MAListDataManager.h"

@interface MAReadLaterListViewController ()

@end

@implementation MAReadLaterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"稍后阅读";

    [[MAListDataManager sharedManager].readList enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
        [self.dataArray addObject:obj];
    }];
}

@end

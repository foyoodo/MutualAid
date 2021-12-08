//
//  MAHomeViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import "MAHomeViewController.h"
#import "MASearchBar.h"
#import "MASearchViewController.h"
#import "MASearchNavigationControllerDelegate.h"
#import "MAPicListCardViewCell.h"

@interface MAHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) MASearchNavigationControllerDelegate *navigationControllerDelegate;

@property (nonatomic, strong) NSMutableArray *picListData;

@end

@implementation MAHomeViewController

@synthesize searchBar = _searchBar;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.fd_prefersNavigationBarHidden = YES;

    self.navigationController.delegate = self.navigationControllerDelegate;

    UITableView *mainTableView = [UITableView new];
    mainTableView.backgroundColor = [UIColor systemBlueColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 15.0, *)) {
        mainTableView.sectionHeaderTopPadding = 0;
    }
    mainTableView.rowHeight = UITableViewAutomaticDimension;
    mainTableView.estimatedRowHeight = 100;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:(_mainTableView = mainTableView)];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    tableHeaderView.backgroundColor = [UIColor systemBlueColor];
    mainTableView.tableHeaderView = tableHeaderView;

    [mainTableView registerClass:[MAPicListCardViewCell class] forCellReuseIdentifier:NSStringFromClass([MAPicListCardViewCell class])];
}

- (void)viewDidLayoutSubviews {
    [self.searchBar roundedWithRadius:15 corner:UIRectCornerTopLeft | UIRectCornerTopRight];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainTableView) {
        static BOOL flag = YES;
        if (scrollView.contentOffset.y >= self.mainTableView.tableHeaderView.frame.size.height - self.mainTableView.safeAreaInsets.top) {
            if (flag) {
                flag = NO;
                [UIView animateWithDuration:0.1 animations:^{
                    self.mainTableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
                    self.mainTableView.tableHeaderView.backgroundColor = [UIColor systemGroupedBackgroundColor];
                }];
            }
        } else {
            flag = YES;
            [UIView animateWithDuration:0.1 animations:^{
                self.mainTableView.backgroundColor = [UIColor systemBlueColor];
                self.mainTableView.tableHeaderView.backgroundColor = [UIColor systemBlueColor];
            }];
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 300;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.searchBar.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.searchBar;
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.mainTableView) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.picListData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [UIColor systemGroupedBackgroundColor];
        return cell;
    } else if (indexPath.section == 1) {
        MAPicListCardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MAPicListCardViewCell class])];
        cell.title = [NSString stringWithFormat:@"Title %zd", indexPath.row];
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - MASearchBarDelegate

- (void)searchBarDidClick {
    MASearchViewController *searchVC = [MASearchViewController new];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - Lazy Load

- (MASearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [MASearchBar new];
        _searchBar.backgroundColor = [UIColor systemGroupedBackgroundColor];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (MASearchNavigationControllerDelegate *)navigationControllerDelegate {
    if (!_navigationControllerDelegate) {
        _navigationControllerDelegate = [MASearchNavigationControllerDelegate new];
    }
    return _navigationControllerDelegate;
}

- (NSMutableArray *)picListData {
    if (!_picListData) {
        _picListData = [NSMutableArray array];
        [_picListData addObjectsFromArray:@[@"0",@"1", @"2", @"3", @"4"].mutableCopy];
    }
    return _picListData;
}

@end

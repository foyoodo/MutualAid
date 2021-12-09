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
#import "MAPicListCardTableViewCell.h"
#import "MASectionHeaderView.h"
#import "MAHotNewsView.h"

@interface MAHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *safeAreaTopMaskView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) MAHotNewsView *hotNewsView;

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
    mainTableView.backgroundColor = [UIColor colorNamed:@"AccentColor"];
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
    tableHeaderView.backgroundColor = [UIColor colorNamed:@"AccentColor"];
    mainTableView.tableHeaderView = tableHeaderView;

    [mainTableView registerClass:[MAPicListCardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MAPicListCardTableViewCell class])];

    MAHotNewsView *hotNewsView = [MAHotNewsView new];
    [mainTableView addSubview:(_hotNewsView = hotNewsView)];
    [hotNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainTableView).offset(388 + 4);
        make.left.equalTo(mainTableView).offset(12);
        make.width.equalTo(mainTableView).offset(-24);
    }];

    UIView *safeAreaTopMaskView = [UIView new];
    safeAreaTopMaskView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:(_safeAreaTopMaskView = safeAreaTopMaskView)];
    [safeAreaTopMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
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
                    self.safeAreaTopMaskView.backgroundColor = [UIColor systemGroupedBackgroundColor];
                }];
                self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            }
        } else {
            flag = YES;
            [UIView animateWithDuration:0.1 animations:^{
                self.mainTableView.backgroundColor = [UIColor colorNamed:@"AccentColor"];
                self.mainTableView.tableHeaderView.backgroundColor = [UIColor colorNamed:@"AccentColor"];
                self.safeAreaTopMaskView.backgroundColor = [UIColor clearColor];
            }];
            self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    } else if (indexPath.section == 1) {
        return [MAHotNewsView height];
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.searchBar.height;
    }
    return [MASectionHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.searchBar;
    } else if (section == 1) {
        return [[MASectionHeaderView alloc] initWithTitle:@"Hot News".localized];
    } else if (section == 2) {
        return [[MASectionHeaderView alloc] initWithTitle:@"Offline Course".localized];
    }
    return [[MASectionHeaderView alloc] initWithTitle:@"None".localized];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.mainTableView) {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else if (section == 2) {
        return self.picListData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        MAPicListCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MAPicListCardTableViewCell class])];
        cell.title = [NSString stringWithFormat:@"%@ %zd", @"Title".localized, indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor systemGroupedBackgroundColor];
    return cell;
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
        [_picListData addObjectsFromArray:@[@"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"].mutableCopy];
    }
    return _picListData;
}

@end

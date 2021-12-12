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
#import "MANavigationBar.h"
#import "MAPicListModel.h"

@interface MAHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MAHotNewsView *hotNewsView;

@property (nonatomic, strong) MASearchNavigationControllerDelegate *navigationControllerDelegate;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *picListData;

@end

@implementation MAHomeViewController

@synthesize searchBar = _searchBar;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.fd_prefersNavigationBarHidden = YES;

    self.navigationController.delegate = self.navigationControllerDelegate;

    self.mainTableView.backgroundColor = [UIColor colorNamed:@"AccentColor"];
    self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    MANavigationBar *navigationBar = [[MANavigationBar alloc] initWithFrame:CGRectMake(0, 0, 0, 90)];
    self.mainTableView.tableHeaderView = navigationBar;

    self.stickyView = self.searchBar;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 15.0, *)) {
        tableView.sectionHeaderTopPadding = 0;
    }
    tableView.bounces = NO;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;

    tableView.sectionFooterHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.mainTableView addSubview:(_tableView = tableView)];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainTableView).offset(navigationBar.frame.size.height + [self heightForStickyView]);
        make.width.equalTo(self.mainTableView);
        make.height.equalTo(self.mainTableView);
    }];
    [tableView registerClass:[MAPicListCardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MAPicListCardTableViewCell class])];

    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 8)];
    tableFooterView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    tableView.tableFooterView = tableFooterView;

    MAHotNewsView *hotNewsView = [MAHotNewsView new];
    [tableView addSubview:(_hotNewsView = hotNewsView)];
    [hotNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableView).offset([MASectionHeaderView height]);
        make.left.equalTo(tableView).offset(12);
        make.width.equalTo(tableView).offset(-24);
    }];
}

- (void)viewDidLayoutSubviews {
    [self.searchBar roundedWithRadius:15 corner:UIRectCornerTopLeft | UIRectCornerTopRight];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mainTableView).offset(-[self heightForStickyView] - self.view.safeAreaInsets.bottom - self.view.safeAreaInsets.top);
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainTableView) {
        CGFloat alpha = fmin(fmax((1 - scrollView.contentOffset.y / (self.mainTableView.tableHeaderView.frame.size.height - self.view.safeAreaInsets.top)), 0), 1);
        self.mainTableView.backgroundColor = [[UIColor colorNamed:@"AccentColor"] colorWithAlphaComponent:alpha];

        if (self.tableView.contentOffset.y > 0) {
            self.mainTableView.contentOffset = CGPointMake(self.mainTableView.contentOffset.x, self.mainTableView.tableHeaderView.frame.size.height - self.view.safeAreaInsets.top);
        }
    }

    if (self.mainTableView.contentOffset.y < self.mainTableView.tableHeaderView.frame.size.height - self.view.safeAreaInsets.top) {
        self.tableView.contentOffset = CGPointZero;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [MAHotNewsView height];
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MASectionHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if  (section == 0) {
        return [[MASectionHeaderView alloc] initWithTitle:@"Hot News".localized];
    } else if (section == 1) {
        return [[MASectionHeaderView alloc] initWithTitle:@"Offline Course".localized];
    }
    return [[MASectionHeaderView alloc] initWithTitle:@"None".localized];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
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
    if (indexPath.section == 1) {
        MAPicListCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MAPicListCardTableViewCell class])];
        [cell setData:[self.picListData objectAtIndex:indexPath.row]];
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

#pragma mark - MAStickyBaseProtocol

- (CGFloat)heightForStickyView {
    return self.searchBar.height;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height - self.view.safeAreaInsets.top - [self heightForStickyView];
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

- (NSMutableArray<MAPicListModel *> *)picListData {
    if (!_picListData) {
        _picListData = [NSMutableArray array];
        [_picListData addObjectsFromArray:@[
            [MAPicListModel modelWithTitle:@"常见急症急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/68f4534217eda27fdb5b81ecb513a741.jpg"],
            [MAPicListModel modelWithTitle:@"公众 CPR AED 课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/d4bf7b3e8ebe404ab48710c19afd3ae3.jpg"],
            [MAPicListModel modelWithTitle:@"公众必会急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/8062674e17bcbcc8c920d06597b73a07.jpg"],
            [MAPicListModel modelWithTitle:@"美国心脏协会心脏救护员课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/ed37a644d441d0d3694569d47bb5da9f.jpg"],
            [MAPicListModel modelWithTitle:@"国际野外医学协会野外高级急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/c5451deb77b9185a79410b33f2096958.jpg"],
            [MAPicListModel modelWithTitle:@"常见急症急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/68f4534217eda27fdb5b81ecb513a741.jpg"],
            [MAPicListModel modelWithTitle:@"公众 CPR AED 课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/d4bf7b3e8ebe404ab48710c19afd3ae3.jpg"],
            [MAPicListModel modelWithTitle:@"公众必会急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/8062674e17bcbcc8c920d06597b73a07.jpg"],
            [MAPicListModel modelWithTitle:@"美国心脏协会心脏救护员课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/ed37a644d441d0d3694569d47bb5da9f.jpg"],
            [MAPicListModel modelWithTitle:@"国际野外医学协会野外高级急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/c5451deb77b9185a79410b33f2096958.jpg"]
        ]];
    }
    return _picListData;
}

@end

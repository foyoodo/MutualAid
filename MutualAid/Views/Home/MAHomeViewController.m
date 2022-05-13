//
//  MAHomeViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import "MAHomeViewController.h"
#import "MAStickyScrollView.h"
#import "MASearchBar.h"
#import "MASearchViewController.h"
#import "MASearchNavigationControllerDelegate.h"
#import "MAPicListCardTableViewCell.h"
#import "MASectionHeaderView.h"
#import "MACycleBannerView.h"
#import "MATopListView.h"
#import "MAHotNewsView.h"
#import "MANavigationBar.h"
#import "MAPicListModel.h"
#import "MJRefresh.h"
#import "MAMediator+BaseActions.h"
#import "CTMediator+HandyTools.h"

@interface MAHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MAStickyScrollView *stickyScrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MACycleBannerView *cycleBannerView;
@property (nonatomic, strong) MATopListView *topListView;
@property (nonatomic, strong) MAHotNewsView *hotNewsView;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *picListData;

@end

@implementation MAHomeViewController

@synthesize searchBar = _searchBar;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];

    CGFloat cycleBannerViewHeight = floor(([UIScreen mainScreen].bounds.size.width - 12 * 2) * 0.35);

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 15.0, *)) {
        tableView.sectionHeaderTopPadding = 0;
    }
    tableView.contentInset = UIEdgeInsetsMake(4 + cycleBannerViewHeight + 12 + [MATopListView height], 0, 0, 0);
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;
    tableView.sectionFooterHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView.mj_header endRefreshing];
        });
    }];
    tableView.mj_header.automaticallyChangeAlpha = YES;

    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 12)];
    tableFooterView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    tableView.tableFooterView = tableFooterView;

    [tableView registerClass:[MAPicListCardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MAPicListCardTableViewCell class])];

    MAHotNewsView *hotNewsView = [MAHotNewsView new];
    [tableView addSubview:(_hotNewsView = hotNewsView)];
    [hotNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableView).offset([MASectionHeaderView height]);
        make.left.equalTo(tableView).offset(12);
        make.width.equalTo(tableView).offset(-24);
    }];

    MATopListView *topListView = [MATopListView new];
    [tableView addSubview:(_topListView = topListView)];
    [topListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableView).offset(12);
        make.bottom.equalTo(tableView.mas_top);
        make.width.equalTo(tableView).offset(-24);
    }];

    MACycleBannerView *cycleBannerView = [MACycleBannerView new];
    cycleBannerView.frame = CGRectMake(12, -[MATopListView height] - 12 - cycleBannerViewHeight, [UIScreen mainScreen].bounds.size.width - 24, cycleBannerViewHeight);
    cycleBannerView.collectionView.layer.cornerRadius = 8;
    [tableView addSubview:(_cycleBannerView = cycleBannerView)];

    MANavigationBar *navigationBar = [[MANavigationBar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    [navigationBar addRightBarButtonItem:[MABarButtonItem itemWithImage:[[UIImage imageNamed:@"message_normal"] resizeWithHeight:22] handler:^{
        UIViewController *vc = [NSClassFromString(@"MAMessageCenterViewController") new];
        [self.navigationController pushViewController:vc animated:YES];
    }]];

    MAStickyScrollView *stickyScrollView = [[MAStickyScrollView alloc] initWithScrollView:(_tableView = tableView)];
    stickyScrollView.stickyContainerBackgroundView.backgroundColor = [UIColor accentColor];
    stickyScrollView.stickyHeaderView = navigationBar;
    stickyScrollView.stickyView = self.searchBar;

    [self.view addSubview:(_stickyScrollView = stickyScrollView)];
    [stickyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self requestData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if (self.tableView.mj_header.ignoredScrollViewContentInsetTop == 0) {
        self.tableView.mj_header.ignoredScrollViewContentInsetTop = self.stickyScrollView.stickyHeaderViewHeight + self.stickyScrollView.contentInset.top - self.stickyScrollView.stickyContainerViewHeight;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];

    [self.cycleBannerView adjustPosition];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Private Methods

- (void)requestData {
    [self.cycleBannerView setData:@[
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/d64b5e0b83d924ad8b9affe8a67d97e4.jpg" jumpUrl:@"https://h-gracetc.cn:9360/hhfxiang/train.html"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/3e6a75e32015fd3cb48b9fd0b74067fb.jpg" jumpUrl:@"https://www.wenjuan.com/s/UZBZJvuOuX/"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/4d7c82c756cb682536b8b69e582bc92b.jpg" jumpUrl:@"http://a.xiumi.us/stage/v5/2Y0D4/342485170/#/"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/c1765bf23382cad56bbbe64608d2d23a.jpg" jumpUrl:@"http://v.xiumi.us/stage/v5/2Y0D4/342768870"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/bb3275d037d620b867f723090e829e59.jpg" jumpUrl:@"http://v.xiumi.us/stage/v5/2Y0D4/342863542"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/2d11cbeb7aa52bac369e50cf1bcd0cf8.jpg" jumpUrl:@"http://v.xiumi.us/stage/v5/2Y0D4/343429730"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/8bbea80510ebb299cbbbe84ff50d8978.jpg" jumpUrl:@"http://v.xiumi.us/stage/v5/2Y0D4/343812602"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/e928630ae162d7d917179382ee04783f.jpg" jumpUrl:@"https://mp.weixin.qq.com/s?__biz=MzA3MTMxODA2Ng==&mid=2650420564&idx=1&sn=4a307e8a5b1e192484b790599239ef43&chksm=8721fa09b056731ff1e332e2ba730f51e29449b212430d06bfe85c80b5ce6fe7eb78269a0a98&token=1749941061&lang=zh_CN#rd"],
        [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/c5dcf2ac9a99a4da14aba294e82277dd.jpg" jumpUrl:@"https://www.wjx.cn/vj/wGyy4kL.aspx"],
    ]];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = 1 - fmin(1, fabs((scrollView.contentOffset.y + self.stickyScrollView.contentInset.top) / 44));
    if (self.stickyScrollView.stickyContainerBackgroundView.alpha != alpha) {
        self.stickyScrollView.stickyContainerBackgroundView.alpha = alpha;
        self.stickyScrollView.stickyHeaderView.alpha = alpha;
    }

    CGFloat contentOffset = scrollView.contentOffset.y + self.stickyScrollView.contentInset.top + self.stickyScrollView.safeAreaInsets.top;
    if (contentOffset < self.stickyScrollView.stickyHeaderViewHeight) {
        self.stickyScrollView.stickyContainerView.backgroundColor = [UIColor clearColor];
    } else {
        self.stickyScrollView.stickyContainerView.backgroundColor = [UIColor systemGroupedBackgroundColor];
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
    if (section == 0) {
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

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        MAPicListCardTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section]];
        if (cell) {
            cell.separatorView.hidden = YES;
        }
        cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.containerView.backgroundColor = [UIColor systemGray5Color];
        if (indexPath.row < self.picListData.count - 1) {
            cell.separatorView.hidden = YES;
        }
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        MAPicListCardTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section]];
        if (cell) {
            cell.separatorView.hidden = NO;
        }
        cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.containerView.backgroundColor = [UIColor whiteColor];
        if (indexPath.row < self.picListData.count - 1) {
            cell.separatorView.hidden = NO;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UIViewController *webViewController = [[MAMediator sharedInstance] baseActions_webViewControllerWithTitle:[self.picListData objectAtIndex:indexPath.row].title requestURL:[NSURL URLWithString:[self.picListData objectAtIndex:indexPath.row].jumpUrl]];
        [CT() pushViewController:webViewController animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
        if (indexPath.row == 0) {
            cell.containerView.layer.cornerRadius = 8;
            cell.containerView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
        } else if (indexPath.row == self.picListData.count - 1) {
            cell.containerView.layer.cornerRadius = 8;
            cell.containerView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
            cell.separatorView.hidden = YES;
        }
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
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - Lazy Load

- (MASearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [MASearchBar new];
        _searchBar.frame = CGRectMake(0, 0, 0, _searchBar.height);
        _searchBar.backgroundColor = [UIColor systemGroupedBackgroundColor];
        _searchBar.layer.cornerRadius = 16;
        _searchBar.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (NSMutableArray<MAPicListModel *> *)picListData {
    if (!_picListData) {
        _picListData = [NSMutableArray array];
        [_picListData addObjectsFromArray:@[
            [MAPicListModel modelWithTitle:@"常见急症急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/68f4534217eda27fdb5b81ecb513a741.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/courseMessage?id=15"],
            [MAPicListModel modelWithTitle:@"公众 CPR AED 课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/d4bf7b3e8ebe404ab48710c19afd3ae3.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/courseMessage?id=14"],
            [MAPicListModel modelWithTitle:@"公众必会急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/8062674e17bcbcc8c920d06597b73a07.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/courseMessage?id=18"],
            [MAPicListModel modelWithTitle:@"美国心脏协会心脏救护员课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/ed37a644d441d0d3694569d47bb5da9f.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/courseMessage?id=18"],
            [MAPicListModel modelWithTitle:@"国际野外医学协会野外高级急救课程" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_course/coursePic/c5451deb77b9185a79410b33f2096958.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/courseMessage?id=12"],
        ]];
    }
    return _picListData;
}

@end

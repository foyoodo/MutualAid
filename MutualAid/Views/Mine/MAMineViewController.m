//
//  MAMineViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/17.
//

#import "MAMineViewController.h"
#import "MAStickyScrollView.h"
#import "MAMineStickyView.h"
#import "MANavigationBar.h"
#import "MASectionHeaderView.h"
#import "MAMineHeaderView.h"
#import "MAImageTitleModel.h"
#import "MAMineRecommendedServiceView.h"
#import "MAMediator+BaseActions.h"

static const CGFloat kStickyViewHeight = 90;

@interface MAMineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MAStickyScrollView *stickyScrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MAMineStickyView *stickyView;

@property (nonatomic, strong) MAMineRecommendedServiceView *recommendedServiceView;

@property (nonatomic, strong) NSMutableArray<MAImageTitleModel *> *imageTitleArray;

@end

@implementation MAMineViewController

#pragma mark - Life Cycle

- (void)dealloc {
    [[MAMediator sharedInstance] MAMediator_cleanTableViewCellTarget];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.sectionFooterHeight = 0;
    tableView.estimatedRowHeight = 100;
    tableView.verticalScrollIndicatorInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;

    MAMineStickyView *stickyView = [[MAMineStickyView alloc] initWithFrame:CGRectMake(0, 0, 0, kStickyViewHeight)];

    MANavigationBar *navigationBar = [[MANavigationBar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    navigationBar.backgroundColor = [UIColor colorNamed:@"AccentColor"];
    [navigationBar addRightBarButtonItem:[MABarButtonItem itemWithImage:[UIImage imageNamed:@"settings_normal"] handler:nil]];

    MAMineHeaderView *headerView = [MAMineHeaderView new];
    headerView.frame = CGRectMake(0, 0, 0, [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    tableView.tableHeaderView = headerView;

    MAStickyScrollView *stickyScrollView = [[MAStickyScrollView alloc] initWithScrollView:(_tableView = tableView)];
    stickyScrollView.stickyHeaderView = navigationBar;
    stickyScrollView.stickyView = (_stickyView = stickyView);
    [self.view addSubview:(_stickyScrollView = stickyScrollView)];
    [stickyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    MAMineRecommendedServiceView *recommendedServiceView = [MAMineRecommendedServiceView new];
    [tableView addSubview:(_recommendedServiceView = recommendedServiceView)];
    [recommendedServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableView).offset(40 + [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
        make.left.equalTo(tableView).offset(10);
        make.width.equalTo(tableView).offset(-20);
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.stickyScrollView.stickyContainerView.superview == self.stickyScrollView) {
        CGFloat contentOffset = scrollView.contentOffset.y + kStickyViewHeight + self.view.safeAreaInsets.top;
        CGRect frame = self.stickyView.frame;
        if (contentOffset > 0) {
            frame.size.height = fmax(kStickyViewHeight - contentOffset, 56);
            self.stickyView.frame = frame;

            CGFloat opacity = fmin(contentOffset, 50) / 500;
            self.stickyView.layer.shadowOpacity = opacity;
        } else {
            frame.size.height = kStickyViewHeight;

            if (self.stickyView.layer.shadowOpacity != 0) {
                self.stickyView.layer.shadowOpacity = 0;
            }
        }
        self.stickyView.frame = frame;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    [[MAMediator sharedInstance] MAMediator_configTableViewCell:cell withTitle:[self.imageTitleArray objectAtIndex:indexPath.row].title andImage:[self.imageTitleArray objectAtIndex:indexPath.row].image];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MASectionHeaderView *sectionHeaderView = nil;
    if (section == 0) {
        sectionHeaderView = [[MASectionHeaderView alloc] initWithTitle:@"Recommended Service".localized];
    } else if (section == 1) {
        sectionHeaderView = [[MASectionHeaderView alloc] initWithTitle:@"More Service".localized];
    }
    sectionHeaderView.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    sectionHeaderView.paddingLeft = 12;
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self.recommendedServiceView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.imageTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    return [[MAMediator sharedInstance] MAMediator_cellForTableView:tableView withFont:[UIFont systemFontOfSize:15] andIdentifier:@"id"];
}

#pragma mark - Lazy Load

- (NSMutableArray<MAImageTitleModel *> *)imageTitleArray {
    if (!_imageTitleArray) {
        _imageTitleArray = [@[
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"questionmark"] title:@"联系我们"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"figure.walk"] title:@"关怀模式"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"gearshape"] title:@"设置"]
        ] mutableCopy];
    }
    return _imageTitleArray;
}

@end

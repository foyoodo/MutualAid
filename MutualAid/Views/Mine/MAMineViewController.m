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

static const CGFloat kStickyViewHeight = 80;

@interface MAMineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MAStickyScrollView *stickyScrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MAMineStickyView *stickyView;

@end

@implementation MAMineViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.sectionFooterHeight = 0;
    tableView.estimatedRowHeight = 100;
    tableView.delegate = self;
    tableView.dataSource = self;

    MAMineStickyView *stickyView = [[MAMineStickyView alloc] initWithFrame:CGRectMake(0, 0, 0, kStickyViewHeight)];

    MANavigationBar *navigationBar = [[MANavigationBar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    navigationBar.backgroundColor = [UIColor colorNamed:@"AccentColor"];
    [navigationBar addRightBarButtonItem:[MABarButtonItem itemWithImage:[UIImage imageNamed:@"settings_normal"] handler:nil]];

    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    tableView.tableHeaderView = tableHeaderView;

    MAStickyScrollView *stickyScrollView = [[MAStickyScrollView alloc] initWithScrollView:(_tableView = tableView)];
    stickyScrollView.stickyHeaderView = navigationBar;
    stickyScrollView.stickyView = (_stickyView = stickyView);
    [self.view addSubview:(_stickyScrollView = stickyScrollView)];
    [stickyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
        } else {
            frame.size.height = kStickyViewHeight;
        }
        self.stickyView.frame = frame;
    }
}

#pragma mark - UITableViewDelegate

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
        return 200;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [UITableViewCell new];
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage systemImageNamed:@"book"];
    return cell;
}

@end

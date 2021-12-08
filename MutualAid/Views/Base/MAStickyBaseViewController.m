//
//  MAStickyBaseViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/8.
//

#import "MAStickyBaseViewController.h"

@interface MAStickyBaseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableViewCell *reuseCell;

@end

@implementation MAStickyBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *mainTableView = [UITableView new];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 15.0, *)) {
        mainTableView.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:(_mainTableView = mainTableView)];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(heightForRowAtIndexPath:)]) {
        return [self heightForRowAtIndexPath:indexPath];
    }
    return self.mainTableView.frame.size.height;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(heightForStickyView)])  {
        return [self heightForStickyView];
    }
    return self.stickyView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.stickyView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.reuseCell;
}

#pragma mark - Lazy Load

- (UIView *)stickyView {
    if (!_stickyView) {
        _stickyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        _stickyView.backgroundColor = [UIColor systemRedColor];
    }
    return _stickyView;
}

- (UITableViewCell *)reuseCell {
    if (!_reuseCell) {
        _reuseCell = [UITableViewCell new];
    }
    return _reuseCell;
}

@end

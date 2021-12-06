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

@interface MAHomeViewController ()

@property (nonatomic, strong) MASearchNavigationControllerDelegate *navigationControllerDelegate;

@end

@implementation MAHomeViewController

@synthesize searchBar = _searchBar;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.fd_prefersNavigationBarHidden = YES;

    self.navigationController.delegate = self.navigationControllerDelegate;

    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    UIView *contentView = [UIView new];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.equalTo(@(900));
    }];

    MASearchBar *searchBar = [MASearchBar new];
    [contentView addSubview:(_searchBar = searchBar)];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_safeAreaLayoutGuideTop).offset(48);
        make.left.right.equalTo(contentView);
    }];
    [searchBar setDelegate:self];
}

- (MASearchNavigationControllerDelegate *)navigationControllerDelegate {
    if (!_navigationControllerDelegate) {
        _navigationControllerDelegate = [MASearchNavigationControllerDelegate new];
    }
    return _navigationControllerDelegate;
}

#pragma mark - MASearchBarDelegate

- (void)searchBarDidClick {
    MASearchViewController *searchVC = [MASearchViewController new];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end

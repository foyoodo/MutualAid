//
//  MASearchViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import "MASearchViewController.h"
#import "MASearchBar.h"
#import "MASearchRecommendView.h"
#import "MASearchResultView.h"

@interface MASearchViewController ()

@property (nonatomic, strong) MASearchRecommendView *searchRecommendView;
@property (nonatomic, strong) MASearchResultView *searchResultView;

@end

@implementation MASearchViewController

@synthesize searchBar = _searchBar;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    self.ma_prefersTabBarHidden = YES;
    self.view.backgroundColor = [UIColor systemGray5Color];

    MASearchBar *searchBar = [MASearchBar new];
    [self.view addSubview:(_searchBar = searchBar)];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(self.view);
    }];
    [searchBar prepareForTransition];
    [searchBar setDelegate:self];

    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchBar.searchView.textFieldUserInteractionEnabled = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchBar.searchView.textField becomeFirstResponder];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar.searchView.textField resignFirstResponder];
}

#pragma mark - MASearchBarDelegate

- (void)searchBarDidCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy Load

- (MASearchRecommendView *)searchRecommendView {
    if (!_searchRecommendView) {
        _searchRecommendView = [MASearchRecommendView new];
    }
    return _searchRecommendView;
}

- (MASearchResultView *)searchResultView {
    if (!_searchResultView) {
        _searchResultView = [MASearchResultView new];
    }
    return _searchResultView;
}

@end

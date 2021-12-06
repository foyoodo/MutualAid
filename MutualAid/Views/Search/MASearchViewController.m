//
//  MASearchViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import "MASearchViewController.h"
#import "MASearchBar.h"

@interface MASearchViewController ()

@end

@implementation MASearchViewController

@synthesize searchBar = _searchBar;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar.searchView.textField setUserInteractionEnabled:YES];
    [self.searchBar.searchView.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar.searchView.textField resignFirstResponder];
}

#pragma mark - MASearchBarDelegate

- (void)searchBarDidCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

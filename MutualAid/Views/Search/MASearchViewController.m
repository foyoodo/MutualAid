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

    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(self.view);
    }];
    [self.searchBar prepareForTransition];

    [self.view addSubview:self.searchRecommendView];
    [self.searchRecommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];

    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchBar.searchView.textFieldUserInteractionEnabled = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchBar.textField becomeFirstResponder];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar.textField resignFirstResponder];
}

#pragma mark - Private Methods

- (void)doSearch:(NSString *)text {
    BOOL hasContent = text.length > 0;
    self.searchRecommendView.hidden = hasContent;
    if (hasContent || self->_searchResultView) {
        self.searchResultView.hidden = !hasContent;
    }
}

#pragma mark - MASearchBarDelegate

- (void)searchBarDidCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy Load

- (MASearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [MASearchBar new];
        _searchBar.delegate = self;
        @weakify(self)
        [_searchBar.textField.rac_textSignal subscribeNext:^(NSString * _Nullable text) {
            @strongify(self)
            [self doSearch:text];
        }];
    }
    return _searchBar;
}

- (MASearchRecommendView *)searchRecommendView {
    if (!_searchRecommendView) {
        _searchRecommendView = [MASearchRecommendView new];
        @weakify(self)
        _searchRecommendView.doSearchBlock = ^(NSString * _Nonnull text) {
            @strongify(self)
            self.searchBar.textField.text = text;
            // rac_textSignal contacts with `UIControlEventEditingChanged`
            [self.searchBar.textField sendActionsForControlEvents:UIControlEventEditingChanged];
        };
    }
    return _searchRecommendView;
}

- (MASearchResultView *)searchResultView {
    if (!_searchResultView) {
        _searchResultView = [MASearchResultView new];
        @weakify(self)
        _searchResultView.didScrollBlock = ^{
            @strongify(self)
            if (self.searchBar.textField.isFirstResponder) {
                [self.searchBar.textField resignFirstResponder];
            }
        };
        [self.view addSubview:_searchResultView];
        [_searchResultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchBar.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
    }
    return _searchResultView;
}

@end

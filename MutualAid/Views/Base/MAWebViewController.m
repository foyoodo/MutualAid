//
//  MAWebViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import "MAWebViewController.h"
#import <WebKit/WebKit.h>
#import "MAListDataManager.h"

@interface MAWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) BOOL star;

@end

@implementation MAWebViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ma_prefersTabBarHidden = YES;

    self.view.backgroundColor = UIColor.whiteColor;

    WKWebView *webView = [WKWebView new];
    webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:(_webView = webView)];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.bottom.equalTo(self.view);
    }];

    if (self.requestURL) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.requestURL]];
    }

    _star = [[MAListDataManager sharedManager] staredWithItemId:self.requestURL.absoluteString];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:(_star ? @"star.fill" : @"star")] style:UIBarButtonItemStylePlain target:self action:@selector(addToStarList)];
}

- (void)addToStarList {
    _star = !_star;
    if (_star) {
        [[MAListDataManager sharedManager] addToStarList:[MAPicListModel modelWithTitle:self.title picUrl:@"" jumpUrl:self.requestURL.absoluteString]];
    } else {
        [[MAListDataManager sharedManager] removeFromStarListWithItemId:self.requestURL.absoluteString];
    }
    self.navigationItem.rightBarButtonItem.image = [UIImage systemImageNamed:(_star ? @"star.fill" : @"star")];
    [MAToast showMessage:(_star ? @"添加收藏" : @"取消收藏") inView:self.view];
}

@end

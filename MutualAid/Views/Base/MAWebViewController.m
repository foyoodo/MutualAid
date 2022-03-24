//
//  MAWebViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import "MAWebViewController.h"
#import <WebKit/WebKit.h>

@interface MAWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation MAWebViewController

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

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
}

@end

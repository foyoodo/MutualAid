//
//  MAMessageCenterViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/12.
//

#import "MAMessageCenterViewController.h"
#import "MutualAid-Swift.h"

@interface MAMessageCenterViewController ()

@property (nonatomic, strong) MAMessageCenterView *messageCenterView;

@end

@implementation MAMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ma_prefersTabBarHidden = YES;

    self.title = @"Message Center".localized;
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];

    [self.view addSubview:self.messageCenterView];
    [self.messageCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (MAMessageCenterView *)messageCenterView {
    if (!_messageCenterView) {
        _messageCenterView = [[MAMessageCenterView alloc] init];
    }
    return _messageCenterView;
}

@end

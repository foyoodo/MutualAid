//
//  MAMessageCenterViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/12.
//

#import "MAMessageCenterViewController.h"

@interface MAMessageCenterViewController ()

@end

@implementation MAMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ma_prefersTabBarHidden = YES;

    self.title = @"Message Center".localized;
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
}

@end

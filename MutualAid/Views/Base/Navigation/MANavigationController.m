//
//  MANavigationController.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import "MANavigationController.h"
#import "MASearchNavigationControllerDelegate.h"

@interface MANavigationController ()

@property (nonatomic, strong) MASearchNavigationControllerDelegate *navigationDelegate;

@end

@implementation MANavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self.navigationDelegate;
}

- (MASearchNavigationControllerDelegate *)navigationDelegate {
    if (!_navigationDelegate) {
        _navigationDelegate = [MASearchNavigationControllerDelegate new];
    }
    return _navigationDelegate;
}

@end

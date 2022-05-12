//
//  MABaseInteractionController.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/12.
//

#import "MABaseInteractionController.h"

@implementation MABaseInteractionController

- (void)wireToViewController:(UIViewController *)viewController forOperation:(MAInteractionOperation)operation {
    _viewController = viewController;
    _operation = operation;
}

@end

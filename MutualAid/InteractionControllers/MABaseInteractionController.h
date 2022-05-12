//
//  MABaseInteractionController.h
//  MutualAid
//
//  Created by foyoodo on 2022/5/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MAInteractionOperation) {
    MAInteractionOperationPop,
    MAInteractionOperationDismiss,
    MAInteractionOperationTab
};

@interface MABaseInteractionController : UIPercentDrivenInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController forOperation:(MAInteractionOperation)operation;

@property (nonatomic, unsafe_unretained) UIViewController *viewController;

@property (nonatomic, assign) MAInteractionOperation operation;

@property (nonatomic, assign) BOOL interactive;

@end

NS_ASSUME_NONNULL_END

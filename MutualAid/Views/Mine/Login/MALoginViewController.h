//
//  MALoginViewController.h
//  MutualAid
//
//  Created by foyoodo on 2022/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MALoginViewController : UIViewController

@property (nonatomic, copy) void (^loginSucceedBlock)(void);

@end

NS_ASSUME_NONNULL_END
//
//  MAWebViewController.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAWebViewController : UIViewController

@property (nonatomic, strong) NSURL *requestURL;

@property (nonatomic, assign, readonly) BOOL star;

@end

NS_ASSUME_NONNULL_END

//
//  MAToast.h
//  MutualAid
//
//  Created by foyoodo on 2022/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAToast : UILabel

+ (void)showMessage:(NSString *)message inView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END

//
//  MALoginInputView.h
//  MutualAid
//
//  Created by foyoodo on 2022/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern const CGFloat kLoginInputViewCornerRadius;

@interface MALoginInputView : UIView

- (void)showKeyboard;
- (void)hideKeyboard;

@end

NS_ASSUME_NONNULL_END

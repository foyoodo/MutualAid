//
//  MASearchView.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MASearchView : UIControl

- (void)prepareForTransitionIfShow:(BOOL)show;

@property (nonatomic, assign) BOOL textFieldUserInteractionEnabled;

@property (nonatomic, strong, readonly) UIImageView *icon;
@property (nonatomic, strong, readonly) UITextField *textField;

@end

NS_ASSUME_NONNULL_END

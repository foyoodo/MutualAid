//
//  MASectionHeaderView.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MASectionHeaderView : UIView

- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, assign, class, readonly) CGFloat height;

@property (nonatomic, assign) CGFloat paddingLeft;

@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END

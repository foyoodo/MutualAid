//
//  MAStickyScrollView.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAStickyScrollView : UIView

- (instancetype)initWithScrollView:(nullable UIScrollView *)scrollView;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong, readonly) UIView *stickyContainerView;

@property (nonatomic, strong, readonly) UIView *stickyContainerBackgroundView;

@property (nonatomic, strong) UIView *stickyHeaderView;

@property (nonatomic, strong) UIView *stickyView;

@property (nonatomic, assign, readonly) CGFloat stickyContainerViewHeight;
@property (nonatomic, assign, readonly) CGFloat stickyHeaderViewHeight;

@end

NS_ASSUME_NONNULL_END

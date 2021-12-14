//
//  MAStickyScrollView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/13.
//

#import "MAStickyScrollView.h"

@interface MAStickyScrollView ()

@property (nonatomic, strong) UIView *stickyContainerView;
@property (nonatomic, strong) UIView *stickyContainerBackgroundView;

@property (nonatomic, assign) CGFloat stickyContainerViewHeight;
@property (nonatomic, assign) CGFloat stickyHeaderViewHeight;
@property (nonatomic, assign) CGFloat stickyViewHeight;

@property (nonatomic, assign) UIEdgeInsets contentInset;

@end

@implementation MAStickyScrollView

#pragma mark - Init Methods

- (instancetype)init {
    return [self initWithScrollView:nil];
}

- (instancetype)initWithScrollView:(nullable UIScrollView *)scrollView {
    if (self = [super init]) {
        _mainScrollView = scrollView;
        [self.mainScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - Life Cycle

- (void)dealloc {
    [self.mainScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (CGRectEqualToRect(self.stickyContainerView.frame, CGRectZero)) {
        self.stickyHeaderViewHeight = self.stickyHeaderView.bounds.size.height + self.safeAreaInsets.top;
        self.stickyViewHeight = self.stickyView.bounds.size.height;
        self.stickyContainerViewHeight = self.stickyHeaderViewHeight + self.stickyViewHeight;

        self.mainScrollView.frame = self.bounds;
        UIEdgeInsets contentInset = self.mainScrollView.contentInset;
        contentInset.top += self.stickyContainerViewHeight;
        contentInset.bottom += self.safeAreaInsets.bottom;
        self.contentInset = contentInset;
        self.mainScrollView.contentInset = contentInset;
        self.mainScrollView.contentOffset = CGPointMake(0, -contentInset.top);
        self.mainScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.stickyHeaderView.bounds.size.height, 0, 0, 0);
        [self addSubview:self.mainScrollView];

        self.stickyContainerView.frame = CGRectMake(0, -contentInset.top, self.bounds.size.width, self.stickyContainerViewHeight);
        [self.mainScrollView addSubview:self.stickyContainerView];

        self.stickyContainerBackgroundView.frame = self.stickyContainerView.frame;
        [self.mainScrollView insertSubview:self.stickyContainerBackgroundView belowSubview:self.stickyContainerView];

        if (self.stickyHeaderView) {
            self.stickyHeaderView.frame = CGRectMake(0, 0, self.bounds.size.width, self.stickyHeaderViewHeight);
            [self.stickyContainerView addSubview:self.stickyHeaderView];
        }

        self.stickyView.frame = CGRectMake(0, self.stickyHeaderViewHeight, self.bounds.size.width, self.stickyViewHeight);
        [self.stickyContainerView addSubview:self.stickyView];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = (UIScrollView *)object;
        CGFloat contentOffset = scrollView.contentOffset.y + self.contentInset.top + self.safeAreaInsets.top;
        if (contentOffset < self.stickyHeaderViewHeight) {
            if (self.stickyContainerView.superview != self.mainScrollView) {
                CGRect frame = self.stickyContainerView.frame;
                frame.origin.y = -self.contentInset.top;
                self.stickyContainerView.frame = frame;
                self.stickyContainerBackgroundView.frame = frame;
                [self.mainScrollView addSubview:self.stickyContainerBackgroundView];
                [self.mainScrollView addSubview:self.stickyContainerView];
            }
        } else {
            if (self.stickyContainerView.superview != self) {
                CGRect frame = self.stickyContainerView.frame;
                frame.origin.y = -self.stickyHeaderViewHeight + self.safeAreaInsets.top;
                self.stickyContainerView.frame = frame;
                self.stickyContainerBackgroundView.frame = frame;
                [self addSubview:self.stickyContainerBackgroundView];
                [self addSubview:self.stickyContainerView];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Lazy Load

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [UIScrollView new];
    }
    return _mainScrollView;
}

- (UIView *)stickyContainerView {
    if (!_stickyContainerView) {
        _stickyContainerView = [UIView new];
    }
    return _stickyContainerView;
}

- (UIView *)stickyContainerBackgroundView {
    if (!_stickyContainerBackgroundView) {
        _stickyContainerBackgroundView = [UIView new];
    }
    return _stickyContainerBackgroundView;
}

- (UIView *)stickyView {
    if (!_stickyView) {
        _stickyView = [UIView new];
    }
    return _stickyView;
}

@end

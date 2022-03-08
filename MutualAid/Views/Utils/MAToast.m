//
//  MAToast.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/8.
//
//  Reference: https://github.com/chanify/chanify-ios/blob/main/Chanify/Views/Utils/CHToast.m

#import "MAToast.h"

static const NSTimeInterval kAnimationDuration = 0.2;

@implementation MAToast

+ (void)showMessage:(NSString *)message inView:(UIView *)view {
    if (message.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            showToast(view, message);
        });
    }
}

- (void)show:(NSTimeInterval)delay {
    @weakify(self)
    [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:kAnimationDuration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        @strongify(self)
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (void)hide {
    @weakify(self)
    [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        @strongify(self)
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(UIViewAnimatingPosition finalPosition) {
        @strongify(self)
        [self removeFromSuperview];
    }];
}

static inline void showToast(UIView *view, NSString *message) {
    static const CGFloat radius = 16.0;
    NSTimeInterval delay = 0;
    static __weak MAToast *lastToast = nil;
    if (lastToast != nil) {
        delay += 0.2;
        [lastToast hide];
        lastToast = nil;
    }

    MAToast *toast = [MAToast new];
    [view addSubview:(lastToast = toast)];
    toast.text = message;
    toast.alpha = 0;
    toast.transform = CGAffineTransformMakeScale(0.8, 0.8);
    toast.numberOfLines = 1;
    toast.textAlignment = NSTextAlignmentCenter;
    toast.font = [UIFont systemFontOfSize:15];
    toast.textColor = UIColor.whiteColor;
    toast.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    toast.layer.cornerRadius = radius;
    toast.clipsToBounds = YES;

    CGSize size = [toast sizeThatFits:CGSizeMake(view.bounds.size.width * 0.8, radius * 2)];
    size.height = radius * 2;
    size.width += floor(radius * 2);
    size.width = fmax(size.width, radius * 4);

    [toast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view).offset(-80);
        make.centerX.equalTo(view);
        make.size.mas_equalTo(size);
    }];

    [toast show:delay];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * (int64_t)NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast hide];
    });
}

@end

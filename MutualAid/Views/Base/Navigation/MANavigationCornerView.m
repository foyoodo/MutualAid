//
//  MANavigationCornerView.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import "MANavigationCornerView.h"
#import "MAWebViewController.h"

@interface MANavigationCornerView ()

@property (nonatomic, assign) BOOL interactive;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImpactFeedbackGenerator *generator;

@end

@implementation MANavigationCornerView {
    CGFloat _originX;
    CGFloat _originY;
    BOOL _pointInside;
}

+ (instancetype)sharedInstance {
    static MANavigationCornerView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MANavigationCornerView new];
    });
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, 140, 140)]) {
        self.layer.maskedCorners = kCALayerMinXMinYCorner;
        self.layer.cornerRadius = 70;

        self.backgroundColor = [UIColor systemGray2Color];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 40, 20, 20)];
        imageView.image = [UIImage systemImageNamed:@"plus"];
        imageView.tintColor = [UIColor whiteColor];
        [self addSubview:(_imageView = imageView)];

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 80, 20)];
        titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        titleLabel.text = @"稍后阅读";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:(_titleLabel = titleLabel)];
    }
    return self;
}

- (void)startInteractiveTransitionWithViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[MAWebViewController class]]) {
        self.interactive = NO;
        return;
    }

    self.interactive = YES;

    UIWindow *window = [UIApplication sharedApplication].delegate.window;

    CGRect frame = self.frame;
    frame.origin.x = window.frame.size.width;
    frame.origin.y = window.frame.size.height;
    _originX = frame.origin.x;
    _originY = frame.origin.y;
    self.frame = frame;

    _pointInside = NO;
    self.imageView.image = [UIImage systemImageNamed:@"plus"];

    [window addSubview:[MANavigationCornerView sharedInstance]];
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete panGesture:(UIPanGestureRecognizer *)pan {
    if (!self.interactive) {
        return;
    }

    CGRect frame = self.frame;

    percentComplete = fminf(percentComplete, 0.7);

    CGFloat offset = 200 * percentComplete;
    frame.origin.x = _originX - offset;
    frame.origin.y = _originY - offset;

    self.frame = frame;

    CGPoint point = [pan locationInView:self];
    if (point.x > 0 && point.y > 0) {
        if (!_pointInside) {
            _pointInside = YES;
            [self actionWithPointInside:_pointInside];
        }
    } else if (_pointInside) {
        _pointInside = NO;
        [self actionWithPointInside:_pointInside];
    }
}

- (void)cancelInteractiveTransition {
    if (!self.interactive) {
        return;
    }

    [self removeFromSuperview];
}

- (void)finishInteractiveTransition {
    if (!self.interactive) {
        return;
    }

    if (_pointInside) {
        [MAToast showMessage:@"已加入稍后阅读" inView:self.superview];
    }
    CGRect frame = self.frame;
    frame.origin.x = _originX;
    frame.origin.y = _originY;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)actionWithPointInside:(BOOL)pointInside {
    if (pointInside) {
        self.imageView.image = [UIImage systemImageNamed:@"checkmark"];
    } else {
        self.imageView.image = [UIImage systemImageNamed:@"plus"];
    }
    [self.generator impactOccurred];
}

- (UIImpactFeedbackGenerator *)generator {
    if (!_generator) {
        _generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    }
    return _generator;
}

@end

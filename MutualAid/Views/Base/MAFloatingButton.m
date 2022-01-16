//
//  MAFloatingButton.m
//  MutualAid
//
//  Created by foyoodo on 2022/1/14.
//

#import "MAFloatingButton.h"
#import "UIView+FYDraggable.h"

@interface MAFloatingButton () <FYDraggableViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIControl *circle;

@end

@implementation MAFloatingButton

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(300, 300, 112, 56);

        UIView *containerView = [[UIView alloc] initWithFrame:self.bounds];
        containerView.backgroundColor = [UIColor colorNamed:@"AccentColor"];
        containerView.layer.cornerRadius = 28;
        [self addSubview:(_containerView = containerView)];

        UIControl *circle = [UIControl new];
        circle.backgroundColor = [UIColor systemRedColor];
        circle.layer.cornerRadius = 23;
        [self addSubview:(_circle = circle)];
        [circle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.right.bottom.equalTo(self).offset(-5);
            make.width.equalTo(circle.mas_height);
        }];

        self.fy_draggable = YES;
        self.fy_draggableViewDelegate = self;
        self.fy_draggablePanGestureRecognizerView = circle;

        FYDraggableViewConfiguration *configuration = [FYDraggableViewConfiguration configurationWithDirection:FYDraggableViewDirectionAll];
        configuration.recognizerContentInset = UIEdgeInsetsMake(5, 15, 5, 15);
        self.fy_draggableViewConfiguration = configuration;
    }
    return self;
}

#pragma mark - FYDraggableViewDelegate

- (void)fy_draggableViewWillBeginDragging:(UIView *)view {
    CGFloat dx = 56;
    CGRect frame = self.containerView.frame;
    frame.origin.x += dx;
    frame.size.width -= dx;
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.frame = frame;
    }];
}

- (void)fy_draggableViewDidEndDragging:(UIView *)view willDecelerate:(BOOL)decelerate {
    CGFloat dx = 56;
    CGRect frame = self.containerView.frame;
    frame.origin.x -= dx;
    frame.size.width += dx;
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.frame = frame;
    }];
}

@end

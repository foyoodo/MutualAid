//
//  UIView+FYDraggable.m
//  MutualAid
//
//  Created by foyoodo on 2022/1/14.
//

#import "UIView+FYDraggable.h"
#import "NSObject+FYDraggableSupport.h"
#import <objc/runtime.h>

@interface _FYDraggableViewGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

- (instancetype)initWithTargetDraggableView:(UIView *)targetDraggableView;

@property (nonatomic, weak) UIView *targetDraggableView;

@end

@implementation _FYDraggableViewGestureRecognizerDelegate

- (instancetype)init
{
    return [self initWithTargetDraggableView:nil];
}

- (instancetype)initWithTargetDraggableView:(UIView *)targetDraggableView
{
    if (self = [super init]) {
        _targetDraggableView = targetDraggableView;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.targetDraggableView.fy_draggableViewConfiguration.direction == FYDraggableViewDirectionNone) {
        return NO;
    }

    if (self.targetDraggableView.fy_draggablePanGestureRecognizerView == self.targetDraggableView) {
        return YES;
    }

    CGPoint point = [gestureRecognizer locationInView:self.targetDraggableView.fy_draggablePanGestureRecognizerView];
    CGRect bounds = self.targetDraggableView.fy_draggablePanGestureRecognizerView.bounds;
    if (point.x + 15 >= bounds.origin.x && point.x - 15 <= bounds.origin.x + bounds.size.width) {
        if (point.y + 10 >= bounds.origin.y && point.y - 10 <= bounds.origin.y + bounds.size.height) {
            return YES;
        }
    }

    return NO;
}

@end


@implementation FYDraggableViewConfiguration

+ (instancetype)configurationWithDirection:(FYDraggableViewDirection)direction
{
    return [[self alloc] initWithDirection:direction];
}

- (instancetype)init
{
    return [self initWithDirection:FYDraggableViewDirectionAll];
}

- (instancetype)initWithDirection:(FYDraggableViewDirection)direction
{
    if (self = [super init]) {
        _direction = direction;
    }
    return self;
}

@end


@interface UIView (FYDraggable)

@property (nonatomic, assign) CGPoint fy_draggableStartPoint;

@property (nonatomic, strong) _FYDraggableViewGestureRecognizerDelegate *fy_draggableViewGestureRecognizerDelegate;

@end

@implementation UIView (FYDraggable)

- (BOOL)fy_draggable
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFy_draggable:(BOOL)draggable
{
    if (draggable) {
        if (![self.gestureRecognizers containsObject:self.fy_draggablePanGestureRecognizer]) {
            [self addGestureRecognizer:self.fy_draggablePanGestureRecognizer];
            [self.fy_draggablePanGestureRecognizer addTarget:self action:@selector(fy_draggableDragInside:)];
        }
    } else {
        if (objc_getAssociatedObject(self, @selector(fy_draggablePanGestureRecognizer))) {
            [self removeGestureRecognizer:self.fy_draggablePanGestureRecognizer];
        }
    }

    objc_setAssociatedObject(self, @selector(fy_draggable), @(draggable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FYDraggableViewConfiguration *)fy_draggableViewConfiguration
{
    FYDraggableViewConfiguration *configuration = objc_getAssociatedObject(self, _cmd);

    if (!configuration) {
        configuration = [[FYDraggableViewConfiguration alloc] init];
    }

    return configuration;
}

- (void)setFy_draggableViewConfiguration:(FYDraggableViewConfiguration *)draggableViewConfiguration
{
    objc_setAssociatedObject(self, @selector(fy_draggableViewConfiguration), draggableViewConfiguration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer *)fy_draggablePanGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);

    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        panGestureRecognizer.delegate = self.fy_draggableViewGestureRecognizerDelegate;

        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return panGestureRecognizer;
}

- (UIView *)fy_draggablePanGestureRecognizerView
{
    UIView *draggablePanGestureRecognizerView = objc_getAssociatedObject(self, _cmd);

    if (!draggablePanGestureRecognizerView) {
        draggablePanGestureRecognizerView = self;
    }

    return draggablePanGestureRecognizerView;
}

- (void)setFy_draggablePanGestureRecognizerView:(UIView *)draggablePanGestureRecognizerView
{
    objc_setAssociatedObject(self, @selector(fy_draggablePanGestureRecognizerView), draggablePanGestureRecognizerView, OBJC_ASSOCIATION_ASSIGN);
}

- (id<FYDraggableViewDelegate>)fy_draggableViewDelegate
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFy_draggableViewDelegate:(id<FYDraggableViewDelegate>)delegate
{
    objc_setAssociatedObject(self, @selector(fy_draggableViewDelegate), delegate, OBJC_ASSOCIATION_ASSIGN);
    __weak typeof(self) weakSelf = self;
    [(id)delegate fy_draggableSupportRunAtDealloc:^{
        weakSelf.fy_draggableViewDelegate = nil;
    }];
}

- (CGPoint)fy_draggableStartPoint
{
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setFy_draggableStartPoint:(CGPoint)startPoint
{
    objc_setAssociatedObject(self, @selector(fy_draggableStartPoint), @(startPoint), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_FYDraggableViewGestureRecognizerDelegate *)fy_draggableViewGestureRecognizerDelegate
{
    _FYDraggableViewGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);

    if (!delegate) {
        delegate = [[_FYDraggableViewGestureRecognizerDelegate alloc] initWithTargetDraggableView:self];

        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return delegate;
}

- (void)fy_draggableDragInside:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            [pan setTranslation:CGPointZero inView:self];

            self.fy_draggableStartPoint = [pan translationInView:self];

            if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewWillBeginDragging:)]) {
                [self.fy_draggableViewDelegate fy_draggableViewWillBeginDragging:self];
            }
        } break;

        case UIGestureRecognizerStateChanged: {
            CGPoint point = [pan translationInView:self];
            CGFloat dx = point.x - self.fy_draggableStartPoint.x;
            CGFloat dy = point.y - self.fy_draggableStartPoint.y;

            FYDraggableViewDirection direction = self.fy_draggableViewConfiguration.direction;

            if (~direction & FYDraggableViewDirectionUp) {
                dy = MAX(dy, 0);
            }
            if (~direction & FYDraggableViewDirectionDown) {
                dy = MIN(dy, 0);
            }
            if (~direction & FYDraggableViewDirectionLeft) {
                dx = MAX(dx, 0);
            }
            if (~direction & FYDraggableViewDirectionRight) {
                dx = MIN(dx, 0);
            }

            CGPoint center = CGPointMake(self.center.x + dx, self.center.y + dy);
            if (!CGPointEqualToPoint(self.center, center)) {
                self.center = center;

                if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewDidDrag:)]) {
                    [self.fy_draggableViewDelegate fy_draggableViewDidDrag:self];
                }
            }

            [pan setTranslation:CGPointZero inView:self];
        } break;

        case UIGestureRecognizerStateEnded: {
            CGPoint center = self.center;
            CGFloat superFrameWidth = self.superview.frame.size.width;

            if (center.x > superFrameWidth / 2) {
                center.x = superFrameWidth - self.bounds.size.width / 2;
            } else {
                center.x = self.bounds.size.width / 2;
            }

            if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewWillEndDragging:targetCenter:)]) {
                [self.fy_draggableViewDelegate fy_draggableViewWillEndDragging:self targetCenter:center];
            }

            if (!CGPointEqualToPoint(self.center, center)) {
                if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewDidEndDragging:willDecelerate:)]) {
                    [self.fy_draggableViewDelegate fy_draggableViewDidEndDragging:self willDecelerate:YES];
                }

                if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewWillBeginDecelerating:)]) {
                    [self.fy_draggableViewDelegate fy_draggableViewWillBeginDecelerating:self];
                }

                [UIView animateWithDuration:0.3 animations:^{
                    self.center = center;
                } completion:^(BOOL finished) {
                    if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewDidEndDecelerating:)]) {
                        [self.fy_draggableViewDelegate fy_draggableViewDidEndDecelerating:self];
                    }
                }];
            } else {
                if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewDidEndDragging:willDecelerate:)]) {
                    [self.fy_draggableViewDelegate fy_draggableViewDidEndDragging:self willDecelerate:NO];
                }
            }
        } break;

        default:
            break;
    }
}

@end

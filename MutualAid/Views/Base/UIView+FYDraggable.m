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
    FYDraggableViewConfiguration *configuration = self.targetDraggableView.fy_draggableViewConfiguration;

    if (configuration.direction == FYDraggableViewDirectionNone) {
        return NO;
    }

    CGPoint point = [gestureRecognizer locationInView:self.targetDraggableView.fy_draggablePanGestureRecognizerView];
    CGRect bounds = self.targetDraggableView.fy_draggablePanGestureRecognizerView.bounds;

    if (UIEdgeInsetsEqualToEdgeInsets(configuration.recognizerContentInsets, UIEdgeInsetsZero)) {
        return CGRectContainsPoint(bounds, point);
    }
    else {
        BOOL cda = point.x + configuration.recognizerContentInsets.left >= bounds.origin.x && point.x - configuration.recognizerContentInsets.right <= bounds.origin.x + bounds.size.width;
        BOOL cdb = point.y + configuration.recognizerContentInsets.top >= bounds.origin.y && point.y - configuration.recognizerContentInsets.bottom <= bounds.origin.y + bounds.size.height;

        if (cda && cdb) {
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

+ (instancetype)configurationWithDirection:(FYDraggableViewDirection)direction position:(FYDraggableViewPosition)position
{
    return [[self alloc] initWithDirection:direction position:position];
}

- (instancetype)init
{
    return [self initWithDirection:FYDraggableViewDirectionAll];
}

- (instancetype)initWithDirection:(FYDraggableViewDirection)direction
{
    return [self initWithDirection:direction position:FYDraggableViewPositionNone];
}

- (instancetype)initWithDirection:(FYDraggableViewDirection)direction position:(FYDraggableViewPosition)position
{
    if (self = [super init]) {
        _direction = direction;
        _position = position;
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
    }
    else {
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

            CGFloat superFrameWidth = self.superview.frame.size.width;
            CGFloat superFrameHeight = self.superview.frame.size.height;

            UIEdgeInsets extraContentInsets = self.fy_draggableViewConfiguration.extraContentInsets;

            center.x = MAX(center.x, self.bounds.size.width / 2 + self.superview.safeAreaInsets.left + extraContentInsets.left);
            center.x = MIN(center.x, superFrameWidth - self.bounds.size.width / 2 - self.superview.safeAreaInsets.right - extraContentInsets.right);
            center.y = MAX(center.y, self.bounds.size.height / 2 + self.superview.safeAreaInsets.top + extraContentInsets.top);
            center.y = MIN(center.y, superFrameHeight - self.bounds.size.height / 2 - self.superview.safeAreaInsets.bottom - extraContentInsets.bottom);

            if (!CGPointEqualToPoint(self.center, center)) {
                self.center = center;

                if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewDidDrag:)]) {
                    [self.fy_draggableViewDelegate fy_draggableViewDidDrag:self];
                }
            }

            [pan setTranslation:CGPointZero inView:self];
        } break;

        case UIGestureRecognizerStateEnded: {
            FYDraggableViewPosition position = self.fy_draggableViewConfiguration.position;

            if (position == FYDraggableViewPositionNone) {
                if (self.fy_draggableViewDelegate) {
                    if ([self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewWillEndDragging:targetCenter:)]) {
                        [self.fy_draggableViewDelegate fy_draggableViewWillEndDragging:self targetCenter:self.center];
                    }
                    if ([self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewDidEndDragging:willDecelerate:)]) {
                        [self.fy_draggableViewDelegate fy_draggableViewDidEndDragging:self willDecelerate:NO];
                    }
                }
                break;
            }

            UIEdgeInsets extraContentInsets = self.fy_draggableViewConfiguration.extraContentInsets;

            CGPoint center = self.center;
            CGFloat superFrameWidth = self.superview.frame.size.width;
            CGFloat superFrameHeight = self.superview.frame.size.height;

            if (position & FYDraggableViewPositionLeft && position & FYDraggableViewPositionRight) {
                if (center.x < superFrameWidth / 2) {
                    center.x = self.bounds.size.width / 2 + self.superview.safeAreaInsets.left + extraContentInsets.left;
                }
                else {
                    center.x = superFrameWidth - self.bounds.size.width / 2 - self.superview.safeAreaInsets.right - extraContentInsets.right;
                }
            }
            else if (position & FYDraggableViewPositionLeft) {
                center.x = self.bounds.size.width / 2 + self.superview.safeAreaInsets.left + extraContentInsets.left;
            }
            else if (position & FYDraggableViewPositionRight) {
                center.x = superFrameWidth - self.bounds.size.width / 2 - self.superview.safeAreaInsets.right - extraContentInsets.right;
            }


            if (position & FYDraggableViewPositionTop && position & FYDraggableViewPositionBottom) {
                if (center.y < superFrameHeight / 2) {
                    center.y = self.bounds.size.height / 2 + self.superview.safeAreaInsets.top + extraContentInsets.top;
                }
                else {
                    center.y = superFrameHeight - self.bounds.size.height / 2 - self.superview.safeAreaInsets.bottom - extraContentInsets.bottom;
                }
            }
            else if (position & FYDraggableViewPositionTop) {
                center.y = self.bounds.size.height / 2 + self.superview.safeAreaInsets.top + extraContentInsets.top;
            }
            else if (position & FYDraggableViewPositionBottom) {
                center.y = superFrameHeight - self.bounds.size.height / 2 - self.superview.safeAreaInsets.bottom - extraContentInsets.bottom;
            }

            if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewWillEndDragging:targetCenter:)]) {
                [self.fy_draggableViewDelegate fy_draggableViewWillEndDragging:self targetCenter:center];
            }

            if (CGPointEqualToPoint(self.center, center)) {
                if (self.fy_draggableViewDelegate && [self.fy_draggableViewDelegate respondsToSelector:@selector(fy_draggableViewDidEndDragging:willDecelerate:)]) {
                    [self.fy_draggableViewDelegate fy_draggableViewDidEndDragging:self willDecelerate:NO];
                }
            }
            else {
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
            }
        } break;

        default:
            break;
    }
}

@end

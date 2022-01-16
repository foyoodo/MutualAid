//
//  UIView+FYDraggable.h
//  MutualAid
//
//  Created by foyoodo on 2022/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FYDraggableViewDelegate <NSObject>

@optional

- (void)fy_draggableViewDidDrag:(UIView *)view;

- (void)fy_draggableViewWillBeginDragging:(UIView *)view;
- (void)fy_draggableViewWillEndDragging:(UIView *)view targetCenter:(inout CGPoint)targetCenter;
- (void)fy_draggableViewDidEndDragging:(UIView *)view willDecelerate:(BOOL)decelerate;

- (void)fy_draggableViewWillBeginDecelerating:(UIView *)view;
- (void)fy_draggableViewDidEndDecelerating:(UIView *)view;

@end

typedef NS_OPTIONS(NSUInteger, FYDraggableViewDirection) {
    FYDraggableViewDirectionNone       = 0,
    FYDraggableViewDirectionUp         = 1 << 0,
    FYDraggableViewDirectionDown       = 1 << 1,
    FYDraggableViewDirectionLeft       = 1 << 2,
    FYDraggableViewDirectionRight      = 1 << 3,
    FYDraggableViewDirectionAll        = ~0UL,
    FYDraggableViewDirectionHorizontal = FYDraggableViewDirectionLeft | FYDraggableViewDirectionRight,
    FYDraggableViewDirectionVertical   = FYDraggableViewDirectionUp   | FYDraggableViewDirectionDown
};

@interface FYDraggableViewConfiguration : NSObject

+ (instancetype)configurationWithDirection:(FYDraggableViewDirection)direction;

- (instancetype)initWithDirection:(FYDraggableViewDirection)direction;

@property (nonatomic, assign) FYDraggableViewDirection direction;

@property (nonatomic, assign) UIEdgeInsets recognizerContentInset;

@end

@interface UIView (FYDraggable)

@property (nonatomic, assign) BOOL fy_draggable;

@property (nonatomic, strong) FYDraggableViewConfiguration *fy_draggableViewConfiguration;

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fy_draggablePanGestureRecognizer;

@property (nonatomic, weak) UIView *fy_draggablePanGestureRecognizerView;

@property (nonatomic, weak) id<FYDraggableViewDelegate> fy_draggableViewDelegate;

@end

NS_ASSUME_NONNULL_END

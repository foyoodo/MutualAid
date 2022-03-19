//
//  MAFloatingButton.m
//  MutualAid
//
//  Created by foyoodo on 2022/1/14.
//

#import "MAFloatingButton.h"
#import "UIView+FYDraggable.h"

@interface MAFloatingButton () <FYDraggableViewDelegate>

@end

@implementation MAFloatingButton {
    UIColor *_normalColor;
    UIColor *_highlightedColor;
}

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _normalColor = [UIColor colorWithHex:0x0AAC8F];
        _highlightedColor = [UIColor colorWithHex:0x08826C];

        self.frame = CGRectMake(334, 725, 72, 72);
        self.layer.cornerRadius = 36;
        self.backgroundColor = _normalColor;

        self.fy_draggable = YES;
        self.fy_draggableViewDelegate = self;

        FYDraggableViewConfiguration *configuration = [FYDraggableViewConfiguration configurationWithDirection:FYDraggableViewDirectionAll position:FYDraggableViewPositionRight | FYDraggableViewPositionBottom];
        configuration.extraContentInsets = UIEdgeInsetsMake(0, 0, 16, 8);
        self.fy_draggableViewConfiguration = configuration;

        self.titleLabel.numberOfLines = 2;
        [self setAttributedTitle:[[NSAttributedString alloc] initWithString:@"一键呼救" attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightMedium]
        }]  forState:UIControlStateNormal];
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];

        @weakify(self)
        [self addActionBlock:^(id _Nonnull sender) {
            @strongify(self)
            [MAToast showMessage:@"正在呼救..." inView:self.superview];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if (highlighted) {
        self.backgroundColor = _highlightedColor;
    } else {
        self.backgroundColor = _normalColor;
    }
}

@end

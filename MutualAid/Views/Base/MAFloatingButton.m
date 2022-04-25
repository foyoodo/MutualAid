//
//  MAFloatingButton.m
//  MutualAid
//
//  Created by foyoodo on 2022/1/14.
//

#import "MAFloatingButton.h"
#import "UIView+FYDraggable.h"
#import <UserNotifications/UserNotifications.h>

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

            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = @"呼救提醒";
            content.subtitle = @"有一位患者正在呼救...";
            content.userInfo = @{
                @"title": @"患者所在位置",
                @"detail": @"点击图标赶往急救现场",
                @"latitude": @24.588622029882156,
                @"longitude": @118.09502363204956
            };

            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"id" content:content trigger:trigger];

            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@", error);
                }
            }];

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

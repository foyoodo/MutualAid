//
//  MANavigationBar.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import "MANavigationBar.h"

@implementation MABarButtonItem

+ (instancetype)itemWithImage:(UIImage *)image handler:(void (^ _Nullable)(void))handler {
    return [[self alloc] initWithImage:image handler:handler];
}

+ (instancetype)itemWithSystemImageNamed:(NSString *)name handler:(void (^ _Nullable)(void))handler {
    return [[self alloc] initWithSystemImageNamed:name handler:handler];
}

- (instancetype)initWithImage:(UIImage *)image handler:(void (^ _Nullable)(void))handler {
    if (self = [super init]) {
        _image = image;
        _handler = handler;
    }
    return self;
}

- (instancetype)initWithSystemImageNamed:(NSString *)name handler:(void (^ _Nullable)(void))handler {
    return [self initWithImage:[UIImage systemImageNamed:name withConfiguration:[UIImageSymbolConfiguration configurationWithScale:UIImageSymbolScaleLarge]] handler:handler];
}

@end

@interface MANavigationBar ()

@property (nonatomic, strong) UIButton *backBarButton;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSMutableArray<MABarButtonItem *> *rightBarButtonItems;
@property (nonatomic, strong) NSMutableArray<UIButton *> *rightBarButtons;

@end

@implementation MANavigationBar {
    UIButton *_markedRightBarButton;
}

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

#pragma mark - Life Cycle

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        [self setupBarButtonItems];
    }
}

- (void)didMoveToSuperview {
    [self addBackBarButtonIfNeeded];
}

#pragma mark - Public Methods

- (void)addRightBarButtonItem:(MABarButtonItem *)buttonItem {
    if (buttonItem) {
        [self.rightBarButtonItems addObject:buttonItem];
    }
}

#pragma mark - Private Methods

- (void)addBackBarButtonIfNeeded {
    if (self.viewController && self.viewController != self.viewController.navigationController.viewControllers.firstObject) {
        [self addSubview:self.backBarButton];
        [self.backBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.width.height.equalTo(@(44));
        }];
    }
}

- (void)setupBarButtonItems {
    for (MABarButtonItem *buttonItem in self.rightBarButtonItems) {
        UIButton *button = [UIButton new];
        if (buttonItem.image) {
            [button setImage:buttonItem.image forState:UIControlStateNormal];
            [button setAdjustsImageWhenHighlighted:NO];
        }
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_markedRightBarButton) {
                make.right.equalTo(_markedRightBarButton.mas_left).offset(-4);
            } else {
                make.right.equalTo(self).offset(-4);
            }
            make.bottom.equalTo(self);
            make.width.height.equalTo(@(44));
        }];
        [button addActionBlock:^(id  _Nonnull sender) {
            !buttonItem.handler ?: buttonItem.handler();
        } forControlEvents:UIControlEventTouchUpInside];
        [self.rightBarButtons addObject:button];
        _markedRightBarButton = button;
    }
    _markedRightBarButton = nil;
}

- (void)backButtonDidClick {
    if ([self.viewController isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)self.viewController) popViewControllerAnimated:YES];
    } else {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Override

- (UIImage *)backgroundImage {
    return self.backgroundImageView.image;
}

- (void)setBackgroundImage:(UIImage *)image {
    self.backgroundImageView.image = image;
}

#pragma mark - Lazy Load

- (UIButton *)backBarButton {
    if (!_backBarButton) {
        _backBarButton = [UIButton new];
        [_backBarButton setImage:[UIImage systemImageNamed:@"chevron.backward" withConfiguration:[UIImageSymbolConfiguration configurationWithScale:UIImageSymbolScaleLarge]] forState:UIControlStateNormal];
        [_backBarButton addTarget:self action:@selector(backButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBarButton;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
        [self addSubview:_backgroundImageView];
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _backgroundImageView;
}

- (NSMutableArray<MABarButtonItem *> *)rightBarButtonItems {
    if (!_rightBarButtonItems) {
        _rightBarButtonItems = [NSMutableArray array];
    }
    return _rightBarButtonItems;
}

- (NSMutableArray<UIButton *> *)rightBarButtons {
    if (!_rightBarButtons) {
        _rightBarButtons = [NSMutableArray array];
    }
    return _rightBarButtons;
}

@end

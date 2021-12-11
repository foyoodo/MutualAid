//
//  MAStickyBaseViewController.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/8.
//

#import "MAStickyBaseViewController.h"
#import <objc/runtime.h>

@interface MAStickyMainTableView : UITableView <UIGestureRecognizerDelegate> @end

@implementation MAStickyMainTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UICollectionView class]]) {
        UICollectionViewLayout *collectionViewLayout = ((UICollectionView *)otherGestureRecognizer.view).collectionViewLayout;
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            if (((UICollectionViewFlowLayout *)collectionViewLayout).scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                return NO;
            }
        }
    }
    return YES;
}

@end


@interface MAStickyBaseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableViewCell *reuseCell;

@end

@implementation MAStickyBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *mainTableView = [MAStickyMainTableView new];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 15.0, *)) {
        mainTableView.sectionHeaderTopPadding = 0;
    }
    mainTableView.showsVerticalScrollIndicator = NO;
    mainTableView.showsHorizontalScrollIndicator = NO;
    mainTableView.bounces = NO;
    [self.view addSubview:(_mainTableView = mainTableView)];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - Hook

- (CGFloat)stickyView_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        if ([self respondsToSelector:@selector(heightForRowAtIndexPath:)]) {
            return [self heightForRowAtIndexPath:indexPath];
        }
        return self.mainTableView.frame.size.height;
    }
    return [self stickyView_tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)stickyView_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        if ([self respondsToSelector:@selector(heightForStickyView)])  {
            return [self heightForStickyView];
        }
        return self.stickyView.frame.size.height;
    }
    return [self stickyView_tableView:tableView heightForHeaderInSection:section];
}

- (UIView *)stickyView_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        return self.stickyView;
    }
    return [self stickyView_tableView:tableView viewForHeaderInSection:section];
}

- (BOOL)stickyView_tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        return NO;
    }
    return [self stickyView_tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
}

- (NSInteger)stickyView_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        return 1;
    }
    return [self stickyView_tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)stickyView_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        return self.reuseCell;
    }
    return [self stickyView_tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Lazy Load

- (UIView *)stickyView {
    if (!_stickyView) {
        _stickyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        _stickyView.backgroundColor = [UIColor systemRedColor];
    }
    return _stickyView;
}

- (UITableViewCell *)reuseCell {
    if (!_reuseCell) {
        _reuseCell = [UITableViewCell new];
    }
    return _reuseCell;
}

@end

#pragma mark - Categories

@interface NSObject (StickyView) @end

@implementation NSObject (StickyView)

+ (void)swizzleInstanceMethod:(SEL)originalSel withPrefix:(NSString *)prefix {
    SEL swizzledSel = NSSelectorFromString([NSString stringWithFormat:@"%@_%@", prefix, NSStringFromSelector(originalSel)]);

    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);

    IMP originalImp = method_getImplementation(originalMethod);
    IMP swizzledImp = method_getImplementation(swizzledMethod);

    BOOL success = class_addMethod(self, swizzledSel, swizzledImp, method_getTypeEncoding(swizzledMethod));
    if (success) {
        BOOL didAddMethod = class_addMethod(self, originalSel, swizzledImp, method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(self, swizzledSel, originalImp, method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, class_getInstanceMethod(self, swizzledSel));
        }
    }
}

@end

@interface UITableView(StickyView) @end

@implementation UITableView(StickyView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method setDelegate_originalMethod = class_getInstanceMethod(self, @selector(setDelegate:));
        Method setDelegate_swizzledMethod = class_getInstanceMethod(self, @selector(stickyView_setDelegate:));
        method_exchangeImplementations(setDelegate_originalMethod, setDelegate_swizzledMethod);
        
        Method setDataSource_originalMethod = class_getInstanceMethod(self, @selector(setDataSource:));
        Method setDataSource_swizzledMethod = class_getInstanceMethod(self, @selector(stickyView_setDataSource:));
        method_exchangeImplementations(setDataSource_originalMethod, setDataSource_swizzledMethod);
    });
}

#pragma mark - Hook

- (void)stickyView_setDelegate:(id<UITableViewDelegate>)delegate {
    if ([delegate isKindOfClass:[MAStickyBaseViewController class]]) {
        Class clz = [delegate class];
        NSString *prefix = @"stickyView";
        [clz swizzleInstanceMethod:@selector(tableView:heightForRowAtIndexPath:) withPrefix:prefix];
        [clz swizzleInstanceMethod:@selector(tableView:heightForHeaderInSection:) withPrefix:prefix];
        [clz swizzleInstanceMethod:@selector(tableView:viewForHeaderInSection:) withPrefix:prefix];
        [clz swizzleInstanceMethod:@selector(tableView:shouldHighlightRowAtIndexPath:) withPrefix:prefix];
    }
    [self stickyView_setDelegate:delegate];
}

- (void)stickyView_setDataSource:(id<UITableViewDataSource>)dataSource {
    if ([dataSource isKindOfClass:[MAStickyBaseViewController class]]) {
        Class clz = [dataSource class];
        NSString *prefix = @"stickyView";
        [clz swizzleInstanceMethod:@selector(tableView:numberOfRowsInSection:) withPrefix:prefix];
        [clz swizzleInstanceMethod:@selector(tableView:cellForRowAtIndexPath:) withPrefix:prefix];
    }
    [self stickyView_setDataSource:dataSource];
}

@end

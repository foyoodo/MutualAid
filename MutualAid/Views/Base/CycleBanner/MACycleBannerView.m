//
//  MACycleBannerView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//
//  Reference: https://github.com/mengxianliang/XLCycleCollectionView
//

#import "MACycleBannerView.h"
#import "MACycleBannerCollectionViewCell.h"
#import "MAPicListModel.h"
#import "NSTimer+MAExt.h"
#import "MAMediator+BaseActions.h"
#import "CTMediator+HandyTools.h"

static const CGFloat kPageControlHeight = 35.0;
static const NSTimeInterval kCycleScrollInterval = 3.0;

@interface MACycleBannerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *dataSourceArray;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MACycleBannerView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - Life Cycle

- (void)dealloc {
    [self.timer invalidate];
}

- (void)layoutSubviews {
    if (!CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        if (CGRectEqualToRect(self.collectionView.frame, CGRectZero)) {
            self.collectionView.frame = self.bounds;
            self.collectionViewFlowLayout.itemSize = self.bounds.size;
            self.collectionView.contentOffset = CGPointMake(self.bounds.size.width, 0);
            self.pageControl.frame = CGRectMake(0, self.bounds.size.height - kPageControlHeight, self.bounds.size.width, kPageControlHeight);
        }
    }
}

#pragma mark - Public Methods

- (void)setData:(NSArray<MAPicListModel *> *)modelArray {
    [self.dataSourceArray removeAllObjects];
    [self.dataSourceArray addObject:modelArray.lastObject];
    [self.dataSourceArray addObjectsFromArray:modelArray];
    [self.dataSourceArray addObject:modelArray.firstObject];

    [self.collectionView reloadData];

    self.pageControl.numberOfPages = modelArray.count;
}

- (void)adjustPosition {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.pageControl.currentPage + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - Private Mthods

- (void)setupUI {
    UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.minimumLineSpacing = 0;

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:(_collectionViewFlowLayout = collectionViewFlowLayout)];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.panGestureRecognizer.maximumNumberOfTouches = 1;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:(_collectionView = collectionView)];

    [collectionView registerClass:[MACycleBannerCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MACycleBannerCollectionViewCell class])];

    [self addSubview:self.pageControl];

    [self setupTimer];
}

- (void)setupTimer {
    @weakify(self)
    _timer = [NSTimer timerWithTimeInterval:kCycleScrollInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strongify(self)
        [self scrollToNext];
    }];
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:kCycleScrollInterval];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)cycleScroll {
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    if (page == 0) {
        self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width * (self.dataSourceArray.count - 2), 0);
        self.pageControl.currentPage = self.dataSourceArray.count - 2;
    } else if (page == self.dataSourceArray.count - 1) {
        self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width, 0);
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = page - 1;
    }
}

- (void)scrollToNext {
    if (self.collectionView.isDragging) {
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.pageControl.currentPage + 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)pageControlSelectionAction:(UIPageControl *)pageControl {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:pageControl.currentPage + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:kCycleScrollInterval];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self cycleScroll];
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:kCycleScrollInterval];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self cycleScroll];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *webViewController = [[MAMediator sharedInstance] baseActions_webViewControllerWithTitle:@"详情" requestURL:[NSURL URLWithString:[self.dataSourceArray objectAtIndex:indexPath.item].jumpUrl]];
    [CT() pushViewController:webViewController animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MACycleBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MACycleBannerCollectionViewCell class]) forIndexPath:indexPath];
    [cell setData:[self.dataSourceArray objectAtIndex:indexPath.item]];
    return cell;
}

#pragma mark - Lazy Load

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor systemGray5Color];
        [_pageControl addTarget:self action:@selector(pageControlSelectionAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (NSMutableArray<MAPicListModel *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

@end

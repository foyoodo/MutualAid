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

static const CGFloat kPageControlHeight = 35.0;

@interface MACycleBannerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *dataSourceArray;

@end

@implementation MACycleBannerView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeSubViews];
    }
    return self;
}

#pragma mark - Life Cycle

- (void)layoutSubviews {
    if (!CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        if (CGRectEqualToRect(self.collectionView.frame, CGRectZero)) {
            self.collectionView.frame = self.bounds;
        }
        self.collectionViewFlowLayout.itemSize = self.bounds.size;
        self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width, 0);
        self.pageControl.frame = CGRectMake(0, self.bounds.size.height - kPageControlHeight, self.bounds.size.width, kPageControlHeight);
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

#pragma mark - Private Mthods

- (void)initializeSubViews {
    UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.minimumLineSpacing = 0;

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:(_collectionViewFlowLayout = collectionViewFlowLayout)];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self cycleScroll];
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

#pragma mark - Action

- (void)pageControlSelectionAction:(UIPageControl *)pageControl {
    NSInteger page = pageControl.currentPage;
    [self.collectionView setContentOffset:CGPointMake((page + 1) * self.collectionView.bounds.size.width, 0) animated:YES];
}

#pragma mark - Lazy Load

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor systemGray5Color];
        [_pageControl addTarget:self action:@selector(pageControlSelectionAction:) forControlEvents:UIControlEventValueChanged];
        self.pageControl.numberOfPages = self.dataSourceArray.count - 2;
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

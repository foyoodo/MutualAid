//
//  MACycleBannerView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//

#import "MACycleBannerView.h"
#import "MACycleBannerCollectionViewCell.h"
#import "MAPicListModel.h"

@interface MACycleBannerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *dataSourceArray;

@end

@implementation MACycleBannerView

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        [self initializeSubViews];
    }
    return self;
}

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
        if (!CGSizeEqualToSize(self.collectionViewFlowLayout.itemSize, self.bounds.size)) {
            self.collectionViewFlowLayout.itemSize = self.bounds.size;
        }
    }
}

#pragma mark - Public Methods

#pragma mark - Private Mthods

- (void)initializeSubViews {
    UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.minimumLineSpacing = 0;

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:(_collectionViewFlowLayout = collectionViewFlowLayout)];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:(_collectionView = collectionView)];

    [collectionView registerClass:[MACycleBannerCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MACycleBannerCollectionViewCell class])];
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

- (NSMutableArray<MAPicListModel *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
        [_dataSourceArray addObjectsFromArray:@[
            [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/270d8698057bc5d7c1c0a3456cdac295.jpg"],

            [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/5f7e6a0ddd6e327aef1eefdd02bb1d3a.jpg"],
            [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/d64b5e0b83d924ad8b9affe8a67d97e4.jpg"],
            [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/825b9e523a0023cce39701041f3ff259.jpg"],
            [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_banner/bannerImg/270d8698057bc5d7c1c0a3456cdac295.jpg"],

            [MAPicListModel modelWithTitle:@"" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/5f7e6a0ddd6e327aef1eefdd02bb1d3a.jpg"],
        ]];
    }
    return _dataSourceArray;
}


@end

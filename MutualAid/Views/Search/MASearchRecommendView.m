//
//  MASearchRecommendView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/6.
//

#import "MASearchRecommendView.h"
#import "MASearchRecommendCollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface MASearchRecommendView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<NSString *> *titles;

@end

@implementation MASearchRecommendView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:(_collectionView = collectionView)];

        [collectionView registerClass:MASearchRecommendCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(MASearchRecommendCollectionViewCell.class)];
    }
    return self;
}

- (void)layoutSubviews {
    if (CGRectEqualToRect(self.collectionView.frame, CGRectZero)) {
        self.collectionView.frame = CGRectInset(self.bounds, 10, 0);
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.doSearchBlock ?: self.doSearchBlock(self.titles[indexPath.item]);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(arc4random() % 50 + 50, 24);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (NSMutableArray<NSString *> *)titles {
    if (!_titles) {
        _titles = [NSMutableArray arrayWithCapacity:10];

        for (NSInteger i = 0; i < 10; ++i) {
            [_titles addObject:[NSString stringWithFormat:@"reco%zd", i]];
        }
    }
    return _titles;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MASearchRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(MASearchRecommendCollectionViewCell.class) forIndexPath:indexPath];
    cell.title = self.titles[indexPath.item];
    return cell;
}

@end

//
//  MAHotNewsView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import "MAHotNewsView.h"
#import "MAHotNewsCollectionViewCell.h"

@interface MAHotNewsView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation MAHotNewsView

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor systemGroupedBackgroundColor];

        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = [MAHotNewsCollectionViewCell itemSize];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.layer.cornerRadius = 12;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:(_collectionView = collectionView)];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.equalTo(@([MAHotNewsCollectionViewCell itemSize].height));
        }];

        [collectionView registerClass:[MAHotNewsCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MAHotNewsCollectionViewCell class])];
    }
    return self;
}

#pragma mark - Public Methods

+ (CGFloat)height {
    return [MAHotNewsCollectionViewCell itemSize].height + 8;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MAHotNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MAHotNewsCollectionViewCell class]) forIndexPath:indexPath];
    NSMutableString *mutableString = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@ %zd", @"Title".localized, indexPath.item]];
    int n = arc4random() % 4;
    for (int i = 0; i < n; ++i) {
        [mutableString appendString:[mutableString mutableCopy]];
    }
    cell.title = mutableString;
    return cell;
}

#pragma mark - Lazy Load

- (NSMutableArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
        [_dataSourceArray addObjectsFromArray:@[@"0",@"1", @"2", @"3", @"4"].mutableCopy];
    }
    return _dataSourceArray;
}

@end

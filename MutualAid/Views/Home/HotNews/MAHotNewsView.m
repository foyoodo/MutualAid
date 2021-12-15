//
//  MAHotNewsView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import "MAHotNewsView.h"
#import "MAHotNewsCollectionViewCell.h"
#import "MAPicListModel.h"

@interface MAHotNewsView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *dataSourceArray;

@end

@implementation MAHotNewsView

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor systemGroupedBackgroundColor];

        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = [MAHotNewsCollectionViewCell itemSize];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.layer.cornerRadius = 8;
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
    return [MAHotNewsCollectionViewCell itemSize].height;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MAHotNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MAHotNewsCollectionViewCell class]) forIndexPath:indexPath];
    [cell setData:[self.dataSourceArray objectAtIndex:indexPath.item]];
    return cell;
}

#pragma mark - Lazy Load

- (NSMutableArray<MAPicListModel *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
        [_dataSourceArray addObjectsFromArray:@[
            [MAPicListModel modelWithTitle:@"宝山又上新了一批“救命神器” AED，“救”在你身边" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/25d0ac79a76b69342cfff0d2b6193bc9.jpg"],
            [MAPicListModel modelWithTitle:@"“救命神器”AED要配好更要用好" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/2cd4dd3765e34a7c123e792db1719582.jpg"],
            [MAPicListModel modelWithTitle:@"阿伯突然晕倒情况危急 中大校园内AED成功救人" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/a4846a16c9a7bde3f529602f7bf043e3.jpg"],
            [MAPicListModel modelWithTitle:@"全广州已布设超1100台AED，“十四五”期间拟配置4500台" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/e7ce7a399506ce590ce44afa85a020e4.jpg"],
            [MAPicListModel modelWithTitle:@"沈阳大力推进救护培训工作 提高应急救护知识普及率" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/0aa9da09a1d6702c632974f9582f5bc7.jpg"],
        ]];
    }
    return _dataSourceArray;
}

@end

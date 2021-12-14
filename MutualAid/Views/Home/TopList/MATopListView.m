//
//  MATopListView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//

#import "MATopListView.h"
#import "MATopListCollectionViewCell.h"
#import "MAPicListModel.h"

@interface MATopListView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *dataSourceArray;

@end

@implementation MATopListView

#pragma mark - Init Methods

- (instancetype)init {
    if (self = [super init]) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.itemSize = [MATopListCollectionViewCell itemSize];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 4);

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
            make.height.equalTo(@([MATopListView height]));
        }];

        [collectionView registerClass:[MATopListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MATopListCollectionViewCell class])];
    }
    return self;
}

#pragma mark - Public Methods

+ (CGFloat)height {
    return [MATopListCollectionViewCell itemSize].height;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MATopListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MATopListCollectionViewCell class]) forIndexPath:indexPath];
    [cell setData:[self.dataSourceArray objectAtIndex:indexPath.item]];
    return cell;
}

#pragma mark - Lazy Load

- (NSMutableArray<MAPicListModel *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
        [_dataSourceArray addObjectsFromArray:@[
            [MAPicListModel modelWithTitle:@"急救基础" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/0013903ee8cad2958fc1d6de93ccbe51.jpg"],
            [MAPicListModel modelWithTitle:@"心肺复苏" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/8965956a07a106a70c33ddba75a88959.jpg"],
            [MAPicListModel modelWithTitle:@"内科急症" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/0422f36abf168cba8a49edc1ec145231.jpg"],
            [MAPicListModel modelWithTitle:@"创伤急症" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/668f424b99be1b9595eed42bd5823ae1.jpg"],
            [MAPicListModel modelWithTitle:@"环境相关" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/adc2cac347cd729435361e6dcb4583fb.jpg"],

        ]];
    }
    return _dataSourceArray;
}

@end

//
//  MATopListView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/14.
//

#import "MATopListView.h"
#import "MATopListCollectionViewCell.h"
#import "MAPicListModel.h"
#import "MutualAid-Swift.h"

@interface MATopListView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MAPicListModel *> *dataSourceArray;

@property (nonatomic, strong) NSMutableArray<id> *innerListDataArray;

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
        collectionView.layer.cornerRadius = 8;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MATopListInnerViewController *vc = [[MATopListInnerViewController alloc] initWithDataArray:self.innerListDataArray[indexPath.item]];
    vc.title = self.dataSourceArray[indexPath.item].title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

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

- (NSMutableArray<id> *)innerListDataArray {
    if (!_innerListDataArray) {
        _innerListDataArray = [NSMutableArray arrayWithArray:@[
            @[
                [MAPicListModel modelWithTitle:@"脱除手套、洗手" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/bd49693849b48ee70b57bc32a06f24bc.jpg"],
                [MAPicListModel modelWithTitle:@"急救基础知识" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/4d6564df031e100aec1dcf1e9da33810.jpg"],
            ],
            @[
                [MAPicListModel modelWithTitle:@"心肺复苏术及自动体外除颤器" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/169e0ef273a4ab4d05a41000b60889d7.jpg"],
            ],
            @[
                [MAPicListModel modelWithTitle:@"成人窒息" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/f27b0bf73172dcbad13627c836faecc1.jpg"],
                [MAPicListModel modelWithTitle:@"抽搐" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/64faee7ef2f86f9ec885b94e9da2ddf3.jpg"],
                [MAPicListModel modelWithTitle:@"腹痛" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/0d082fb8feb36f0d2cd17d5ce0397177.jpg"],
                [MAPicListModel modelWithTitle:@"腹泻" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/630652f2e6273a81f5fde06c3bc6f810.jpg"],
                [MAPicListModel modelWithTitle:@"过敏反应" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/cb0f7377b98777f140db9c2dbf54ab6a.jpg"],
                [MAPicListModel modelWithTitle:@"晕厥" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/98515c81cfe0229dcfb5fa5cc0de3c9c.jpg"],
                [MAPicListModel modelWithTitle:@"低血糖和糖尿病" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/1826120c65d7ca39bfbc7d6758038446.jpg"],
                [MAPicListModel modelWithTitle:@"运动性低钠血症" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/510b9f509e01b3f46d8ef4276f23337d.jpg"],
                [MAPicListModel modelWithTitle:@"过度通气综合症" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/0e3c58f043796210e6dce2240459a41e.jpg"],
            ],
            @[
                [MAPicListModel modelWithTitle:@"鼻出血" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/267f7b381497f3fbe6c21bf096f3037d.jpg"],
                [MAPicListModel modelWithTitle:@"骨折扭伤" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/0ac90f44ae4c3ae331e1beca2bd989af.jpg"],
                [MAPicListModel modelWithTitle:@"口腔出血" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/28c397d841d8b5f051528659d4b2b4ce.jpg"],
                [MAPicListModel modelWithTitle:@"头颈脊柱损伤" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/4a30b75aa04badabbf29fe73f81c1a20.jpg"],
                [MAPicListModel modelWithTitle:@"牙齿损伤" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/4da99a6a02b0711395ab21c0f7fa228a.jpg"],
                [MAPicListModel modelWithTitle:@"眼外伤" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/4310f3e5a4570e95374d9266d4ea7704.jpg"],
                [MAPicListModel modelWithTitle:@"止血包扎" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/41eff99f738981864aee15ee8b8fe453.jpg"],
                [MAPicListModel modelWithTitle:@"内出血" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/0a469bad0cf407b51f56a7d8e36b375b.jpg"],
                [MAPicListModel modelWithTitle:@"失血性休克" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/d1533008c6e25b1fbbba5d583ad7fbd1.jpg"],
            ],
            @[
                [MAPicListModel modelWithTitle:@"热相关急症" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/b9cf7175c3798406f6fbfb560a2d5dfe.jpg"],
                [MAPicListModel modelWithTitle:@"叮咬伤" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/b2917178edc3d0fc37c907724da952cb.jpg"],
                [MAPicListModel modelWithTitle:@"低温急症" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_type/typeImg/4640353b24fb8763e4212d3e8c795cd4.jpg"],
            ],
        ]];
    }
    return _innerListDataArray;
}

@end

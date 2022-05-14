//
//  MAHotNewsView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import "MAHotNewsView.h"
#import "MAHotNewsCollectionViewCell.h"
#import "MAPicListModel.h"
#import "MAMediator+BaseActions.h"
#import "CTMediator+HandyTools.h"

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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *webViewController = [[MAMediator sharedInstance] baseActions_webViewControllerWithTitle:@"资讯详情" requestURL:[NSURL URLWithString:[self.dataSourceArray objectAtIndex:indexPath.item].jumpUrl] detailListItem:[self.dataSourceArray objectAtIndex:indexPath.item]];
    [CT() pushViewController:webViewController animated:YES];
}

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
            [MAPicListModel modelWithTitle:@"【急救科普】34岁研究生猝死案件警示我们什么" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/c144fe720f6eef7df911430dc034ee76.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=157"],
            [MAPicListModel modelWithTitle:@"【急救科普】“救命神器”会用才行呀！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/45a048a82b396439a623d3ee4437b5a8.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=156"],
            [MAPicListModel modelWithTitle:@"【急救科普】全家受用的“救命术”胸外按压知识点复习" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/e8e178cbc33b68ce845232343dc02326.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=155"],
            [MAPicListModel modelWithTitle:@"救人须担责？“好人法”给你撑腰！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/0b613c9f9ed912871cabe4ebde0334d9.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=154"],
            [MAPicListModel modelWithTitle:@"“救命神器”AED要配好更要用好" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/2cd4dd3765e34a7c123e792db1719582.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=149"],
            [MAPicListModel modelWithTitle:@"阿伯突然晕倒情况危急 中大校园内AED成功救人" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/a4846a16c9a7bde3f529602f7bf043e3.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=148"],
            [MAPicListModel modelWithTitle:@"急救“新”人！苏州高新区新升实小开展救护培训" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/7515abec13a27e25e06b33031193471e.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=143"],
            [MAPicListModel modelWithTitle:@"男子就餐时突然昏迷，杭州一个又一个医生冲了上来" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/2c16526d1cbbd55e41b043f378d6feb6.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=142"],
            [MAPicListModel modelWithTitle:@"浙江印发《关于高水平推进应急救护工作的实施意见》" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/3e50fa76c825705a6c45d4b42ea62a94.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=141"],
            [MAPicListModel modelWithTitle:@"应急救护课程开进初中课堂" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/3b9670c3ede36efe70e4eeee8f3ec670.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=140"],
            [MAPicListModel modelWithTitle:@"上海马拉松官宣：原定今年11月28日举办的赛事延期举行" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/8186324be610d7c5f9f58b77b55e5ed0.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=139"],
            [MAPicListModel modelWithTitle:@"深圳教师打球时突然晕倒，赛场上演“黄金四分钟”教科书式急救" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/8be62c85c1c9594d456394f8148b29e6.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=137"],
            [MAPicListModel modelWithTitle:@"AED“救”在校园！哈工大已标配" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/c8bf76b76e881b7b5a5c14e71038c2f9.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=136"],
            [MAPicListModel modelWithTitle:@"济宁投放32台AED除颤器近一年志愿者队伍增至百余人" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/82806d9f901a3c01dbd9acc02825705d.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=135"],
            [MAPicListModel modelWithTitle:@"广州体育迈入“AED时代”，年底装配达154台" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/415a01d53ad1bcae7a0d8556874042b7.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=134"],
            [MAPicListModel modelWithTitle:@"潍坊市300台自动体外除颤器（AED）将于11月底前完成安装" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/1e7aa91f826507ed1c9869a0ad1b2d23.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=133"],
            [MAPicListModel modelWithTitle:@"四川：学校体育场馆明年底前全部配备AED" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/e5d0fcee1c19d4c26a825975666115b0.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=132"],
            [MAPicListModel modelWithTitle:@"看完文末学员感言 l 合恩这场企业安全急救沙龙，办得值！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/4301af4a62401e284900a1d031d20643.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=131"],
            [MAPicListModel modelWithTitle:@"“救命神器”已安装！海南儋州市初中阶段学校AED自动除颤仪全覆盖" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/7cab517e62c986542a87e3044c5cabe1.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=130"],
            [MAPicListModel modelWithTitle:@"福建区域院前急救与AED论坛培训班在晋江举行" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/d57772b30ab0a10f963553fc897008da.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=129"],
        ]];
    }
    return _dataSourceArray;
}

@end

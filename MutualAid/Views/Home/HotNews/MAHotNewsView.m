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
    UIViewController *webViewController = [[MAMediator sharedInstance] baseActions_webViewControllerWithTitle:@"资讯详情" requestURL:[NSURL URLWithString:[self.dataSourceArray objectAtIndex:indexPath.item].jumpUrl]];
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
            [MAPicListModel modelWithTitle:@"重磅！合恩赛事急救系统 SafeX 3.0 正式发布！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/1b07294a92043241f3fdd327289a7a7c.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=160"],
            [MAPicListModel modelWithTitle:@"聚焦公众急救系统公测 | 点亮生命，长兴在行动！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/4669b904d9edd563e97ab3787d0ccdb9.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=159"],
            [MAPicListModel modelWithTitle:@"首次长兴系统公测！快来！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/42b775b2a61fb06678bb81f4d4db1240.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=158"],
            [MAPicListModel modelWithTitle:@"【急救科普】34岁研究生猝死案件警示我们什么" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/c144fe720f6eef7df911430dc034ee76.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=157"],
            [MAPicListModel modelWithTitle:@"【急救科普】“救命神器”会用才行呀！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/45a048a82b396439a623d3ee4437b5a8.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=156"],
            [MAPicListModel modelWithTitle:@"【急救科普】全家受用的“救命术”胸外按压知识点复习" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/e8e178cbc33b68ce845232343dc02326.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=155"],
            [MAPicListModel modelWithTitle:@"救人须担责？“好人法”给你撑腰！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/0b613c9f9ed912871cabe4ebde0334d9.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=154"],
            [MAPicListModel modelWithTitle:@"解锁长兴县公众互助急救体系" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/f30367bec6f079ef20546b0f313d0c68.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=153"],
            [MAPicListModel modelWithTitle:@"原来长兴这些院校都安装了AED！" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/85a00a7a0cebe5606baa8d1680eacbd4.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=151"],
            [MAPicListModel modelWithTitle:@"“救命神器”AED要配好更要用好" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/2cd4dd3765e34a7c123e792db1719582.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=149"],
            [MAPicListModel modelWithTitle:@"阿伯突然晕倒情况危急 中大校园内AED成功救人" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/a4846a16c9a7bde3f529602f7bf043e3.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=148"],
            [MAPicListModel modelWithTitle:@"急救“新”人！苏州高新区新升实小开展救护培训" picUrl:@"https://www.he-grace.com/files/jjxy_img/jjxy_cover/coverImg/7515abec13a27e25e06b33031193471e.jpg" jumpUrl:@"https://www.he-grace.com/cabinet/app/jjxy/contentMessage?id=143"],
        ]];
    }
    return _dataSourceArray;
}

@end

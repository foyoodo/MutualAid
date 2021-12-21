//
//  MAMineRecommendedServiceView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/21.
//

#import "MAMineRecommendedServiceView.h"
#import "MAMineRecommendedServiceCollectionViewCell.h"
#import "MAMineEntryView.h"
#import "MAImageTitleModel.h"

@interface MAMineRecommendedServiceView () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray<MAImageTitleModel *> *imageTitleArray;

@end

@implementation MAMineRecommendedServiceView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:(_flowLayout = flowLayout)];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.dataSource = self;
        [self addSubview:(_collectionView = collectionView)];
        NSInteger count = (self.imageTitleArray.count - 1) / 4 + 1;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.equalTo(@(([[MAMineEntryView new] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height * count) + ((self.imageTitleArray.count - 1) / 4) * (count - 1)));
        }];

        [collectionView registerClass:[MAMineRecommendedServiceCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MAMineRecommendedServiceCollectionViewCell class])];
    }
    return self;
}

#pragma mark - Life Cycle

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        self.flowLayout.itemSize = CGSizeMake(self.bounds.size.width / 4, [[MAMineEntryView new] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageTitleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MAMineRecommendedServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MAMineRecommendedServiceCollectionViewCell class]) forIndexPath:indexPath];
    cell.entryView.imageView.image = [self.imageTitleArray objectAtIndex:indexPath.row].image;
    cell.entryView.titleLabel.text = [self.imageTitleArray objectAtIndex:indexPath.row].title;
    return cell;
}

#pragma mark - Lazy Load

- (NSMutableArray<MAImageTitleModel *> *)imageTitleArray {
    if (!_imageTitleArray) {
        _imageTitleArray = [@[
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"person"] title:@"个人信息"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"newspaper"] title:@"问卷调查"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"star.circle"] title:@"积分中心"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"bell"] title:@"消息通知"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"questionmark.app"] title:@"服务咨询"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"square.and.pencil"] title:@"意见反馈"]
        ] mutableCopy];
    }
    return _imageTitleArray;
}

@end

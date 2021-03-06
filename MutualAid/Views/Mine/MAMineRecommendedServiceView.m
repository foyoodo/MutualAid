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
#import "MutualAid-Swift.h"

@interface MAMineRecommendedServiceView () <UICollectionViewDelegate, UICollectionViewDataSource>

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
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:(_collectionView = collectionView)];
        NSInteger count = (self.imageTitleArray.count - 1) / 4 + 1;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.equalTo(@([[MAMineEntryView new] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height * count));
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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!MAUserDefaults.standardUserDefaults.userId.intValue) {
        MALoginViewController *loginVC = [MALoginViewController new];
        [self.viewController presentViewController:loginVC animated:YES completion:^{
            [MAToast showMessage:@"????????????" inView:loginVC.view];
        }];
        return;
    }
    if (indexPath.item == 0) {
        MAPersonalViewController *vc = [[MAPersonalViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.item == 3) {
        UIViewController *vc = [NSClassFromString(@"MAMessageCenterViewController") new];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.item == 5) {
        MAFeedbackViewController *vc = [[MAFeedbackViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:vc animated:YES];
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
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"person"] title:@"????????????"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"newspaper"] title:@"????????????"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"star.circle"] title:@"????????????"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"bell"] title:@"????????????"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"questionmark.app"] title:@"????????????"],
            [[MAImageTitleModel alloc] initWithImage:[UIImage systemImageNamed:@"square.and.pencil"] title:@"????????????"]
        ] mutableCopy];
    }
    return _imageTitleArray;
}

@end

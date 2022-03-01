//
//  MASearchResultView.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/6.
//

#import "MASearchResultView.h"
#import "MASearchResultTableViewCell.h"
#import "MAPicListModel.h"

@interface MASearchResultView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MASearchResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

        self.rowHeight = 96;

        self.delegate = self;
        self.dataSource = self;

        [self registerClass:MASearchResultTableViewCell.class forCellReuseIdentifier:NSStringFromClass(MASearchResultTableViewCell.class)];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.dragging) {
        !self.didScrollBlock ?: self.didScrollBlock();
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MASearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MASearchResultTableViewCell.class) forIndexPath:indexPath];
    [cell setData:[MAPicListModel modelWithTitle:[NSString stringWithFormat:@"%zd", indexPath.row] picUrl:nil]];
    return cell;
}

@end

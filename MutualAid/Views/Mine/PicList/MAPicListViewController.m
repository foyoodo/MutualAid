//
//  MAPicListViewController.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import "MAPicListViewController.h"
#import "MAPicListTableViewCell.h"
#import "MAPicListModel.h"
#import "MAMediator+BaseActions.h"

@interface MAPicListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MAPicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ma_prefersTabBarHidden = YES;

    self.view.backgroundColor = [UIColor whiteColor];

    UITableView *tableView = [UITableView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:(_tableView = tableView)];

    [tableView registerNib:[UINib nibWithNibName:@"MAPicListTableViewCell" bundle:nil] forCellReuseIdentifier:@"MAPicListTableViewCell"];
}

- (void)viewDidLayoutSubviews {
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAPicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MAPicListTableViewCell" forIndexPath:indexPath];
    MAPicListModel *listItem = [self.dataArray objectAtIndex:indexPath.row];
    cell.picImageView.yy_imageURL = [NSURL URLWithString:listItem.picUrl];
    cell.titleLabel.text = listItem.title;
    cell.urlLabel.text = listItem.jumpUrl;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    MAPicListModel *listItem = [self.dataArray objectAtIndex:indexPath.row];
    UIViewController *webViewController = [[MAMediator sharedInstance] baseActions_webViewControllerWithTitle:@"详情" requestURL:[NSURL URLWithString:listItem.jumpUrl] detailListItem:listItem];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

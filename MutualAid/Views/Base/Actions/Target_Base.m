//
//  Target_Base.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/23.
//

#import "Target_Base.h"
#import "MAWebViewController.h"

@implementation Target_Base

- (UIViewController *)Action_webViewController:(NSDictionary *)params {
    MAWebViewController *webViewController = [MAWebViewController new];
    webViewController.title = params[@"title"];
    webViewController.requestURL = params[@"requestURL"];
    return webViewController;
}

- (UITableViewCell *)Action_cell:(NSDictionary *)params {
    UITableView *tableView = params[@"tableView"];
    NSString *identifier = params[@"identifier"];
    UIFont *font = params[@"font"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = font;

    return cell;
}

- (void)Action_configCell:(NSDictionary *)params {
    UITableViewCell *cell = params[@"cell"];
    NSString *title = params[@"title"];
    UIImage *image = params[@"image"];

    cell.textLabel.text = title;
    cell.imageView.image = image;
}

@end

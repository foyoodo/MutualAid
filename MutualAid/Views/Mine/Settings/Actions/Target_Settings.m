//
//  Target_Settings.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/8.
//

#import "Target_Settings.h"
#import "MutualAid-Swift.h"

@implementation Target_Settings

- (UIViewController *)Action_settingsViewController:(NSDictionary *)params {
    MASettingsViewController *vc = [MASettingsViewController new];
    return vc;
}

@end

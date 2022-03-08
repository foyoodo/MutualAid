//
//  MAMediator+SettingsActions.m
//  MutualAid
//
//  Created by foyoodo on 2022/3/8.
//

#import "MAMediator+SettingsActions.h"

NSString * const kMAMediatorTargetSettings = @"Settings";

NSString * const kMAMediatorActionSettingsViewController = @"settingsViewController";

@implementation MAMediator (SettingsActions)

- (UIViewController *)Settings_settingsViewController {
    return [self performTarget:kMAMediatorTargetSettings
                        action:kMAMediatorActionSettingsViewController
                        params:nil
             shouldCacheTarget:NO];
}

@end

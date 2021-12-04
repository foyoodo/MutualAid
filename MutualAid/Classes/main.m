//
//  main.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import <UIKit/UIKit.h>
#import "MAAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([MAAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

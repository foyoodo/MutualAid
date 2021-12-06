//
//  MASearchBarDelegate.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MASearchBar;

@protocol MASearchBarDelegate <NSObject>

@optional

- (void)searchBarDidClick;
- (void)searchBarDidCancel;

@property (nonatomic, strong, readonly) MASearchBar *searchBar;

@end

NS_ASSUME_NONNULL_END

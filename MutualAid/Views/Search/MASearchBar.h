//
//  MASearchBar.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/4.
//

#import <UIKit/UIKit.h>
#import "MASearchView.h"
#import "MASearchBarDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASearchBar : UIView

- (void)prepareForTransition;

@property (nonatomic, strong, readonly) MASearchView *searchView;

@property (nonatomic, weak) id<MASearchBarDelegate> delegate;

@property (nonatomic, copy) void (^didClickBlock)(void);

@end

NS_ASSUME_NONNULL_END

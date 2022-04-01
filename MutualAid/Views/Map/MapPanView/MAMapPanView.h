//
//  MAMapPanView.h
//  MutualAid
//
//  Created by foyoodo on 2022/4/1.
//

#import <UIKit/UIKit.h>
#import <HWPanModal/HWPanModal.h>

NS_ASSUME_NONNULL_BEGIN

@class MASearchBar;

@interface MAMapPanView : HWPanModalContentView

@property (nonatomic, weak) MASearchBar *searchBar;

@end

NS_ASSUME_NONNULL_END

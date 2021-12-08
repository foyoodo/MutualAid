//
//  MAStickyBaseViewController.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MAStickyBaseProtocol <NSObject>

@optional

- (CGFloat)heightForStickyView;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MAStickyBaseViewController : UIViewController <MAStickyBaseProtocol>

@property (nonatomic, strong, readonly) UITableView *mainTableView;

@property (nonatomic, strong) UIView *stickyView;

@end

NS_ASSUME_NONNULL_END

//
//  MASearchRecommendView.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MASearchRecommendView : UIView

@property (nonatomic, copy) void (^doSearchBlock)(NSString *text);

@end

NS_ASSUME_NONNULL_END

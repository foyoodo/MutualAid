//
//  MAMapPointViewController.h
//  MutualAid
//
//  Created by foyoodo on 2022/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAMapPointViewController : UIViewController

- (void)pointToTargetAnnotation:(id<MKAnnotation>)annotation;

@end

NS_ASSUME_NONNULL_END

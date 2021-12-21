//
//  MAImageTitleModel.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAImageTitleModel : NSObject

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END

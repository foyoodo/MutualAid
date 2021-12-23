//
//  MAPicListModel.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPicListModel : NSObject

+ (instancetype)modelWithTitle:(NSString *)title picUrl:(NSString *)picUrl;
+ (instancetype)modelWithTitle:(NSString *)title picUrl:(NSString *)picUrl jumpUrl:(nullable NSString *)jumpUrl;

- (instancetype)initWithTitle:(NSString *)title picUrl:(NSString *)picUrl;
- (instancetype)initWithTitle:(NSString *)title picUrl:(NSString *)picUrl jumpUrl:(nullable NSString *)jumpUrl;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *jumpUrl;

@end

NS_ASSUME_NONNULL_END

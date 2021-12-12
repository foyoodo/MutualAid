//
//  MANavigationBar.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MABarButtonItem : NSObject

+ (instancetype)itemWithImage:(UIImage *)image handler:(void (^ _Nullable)(void))handler;
+ (instancetype)itemWithSystemImageNamed:(NSString *)name handler:(void (^ _Nullable)(void))handler;

- (instancetype)initWithImage:(UIImage *)image handler:(void (^ _Nullable)(void))handler;
- (instancetype)initWithSystemImageNamed:(NSString *)name handler:(void (^ _Nullable)(void))handler;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, nullable, copy) void (^handler)(void);

@end

@interface MANavigationBar : UIView

- (void)addRightBarButtonItem:(MABarButtonItem *)buttonItem;

@property (nonatomic, strong) UIImage *backgroundImage;

@end

NS_ASSUME_NONNULL_END

//
//  MAListDataManager.h
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import <Foundation/Foundation.h>
#import "MAPicListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAListDataManager : NSObject

+ (instancetype)sharedManager;

- (void)addToStarList:(MAPicListModel *)listItem;
- (void)addToReadList:(MAPicListModel *)listItem;

- (void)removeFromStarList:(MAPicListModel *)listItem;
- (void)removeFromReadList:(MAPicListModel *)listItem;

- (BOOL)staredWithItemId:(NSString *)itemId;
- (BOOL)readedWithItemId:(NSString *)itemId;

@property (nonatomic, strong, readonly) NSMutableDictionary *starList;
@property (nonatomic, strong, readonly) NSMutableDictionary *readList;

@end

NS_ASSUME_NONNULL_END

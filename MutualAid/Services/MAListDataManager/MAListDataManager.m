//
//  MAListDataManager.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import "MAListDataManager.h"

@interface MAListDataManager ()

@property (nonatomic, strong) NSMutableDictionary *starList;
@property (nonatomic, strong) NSMutableDictionary *readList;

@end

@implementation MAListDataManager

+ (instancetype)sharedManager {
    static MAListDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[MAListDataManager alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _starList = [NSMutableDictionary dictionary];
        _readList = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addToStarList:(MAPicListModel *)listItem {
    [self.starList setValue:listItem forKey:listItem.jumpUrl];
}

- (void)addToReadList:(MAPicListModel *)listItem {
    [self.readList setValue:listItem forKey:listItem.jumpUrl];
}

- (void)removeFromStarList:(MAPicListModel *)listItem {
    [self.starList removeObjectForKey:listItem.jumpUrl];
}

- (void)removeFromReadList:(MAPicListModel *)listItem {
    [self.readList removeObjectForKey:listItem.jumpUrl];
}

- (BOOL)staredWithItemId:(NSString *)itemId {
    return [self.starList objectForKey:itemId] != nil;
}

- (BOOL)readedWithItemId:(NSString *)itemId {
    return [self.readList objectForKey:itemId] != nil;
}

@end

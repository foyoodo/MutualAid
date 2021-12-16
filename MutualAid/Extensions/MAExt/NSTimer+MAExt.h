//
//  NSTimer+MAExt.h
//  MutualAid
//
//  Created by foyoodo on 2021/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (MAExt)

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END

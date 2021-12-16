//
//  NSString+MALocalized.m
//  MutualAid
//
//  Created by foyoodo on 2021/12/6.
//

#import "NSString+MALocalized.h"

@implementation NSString (MALocalized)

- (NSString *)localized {
    return [NSBundle.mainBundle localizedStringForKey:self ?: @"" value:@"" table:nil];
}

@end

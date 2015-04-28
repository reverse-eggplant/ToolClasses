//
//  NSDictionary+SafeAccessor.m
//  VacationIOS
//
//  Created by 巩 鹏军 on 14-3-27.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import "NSDictionary+SafeAccessor.h"

@implementation NSDictionary (SafeAccessor)

- (BOOL)objectForKeyIsNSNull:(NSString*)key;
{
    return [[self objectForKey:key] isKindOfClass:[NSNull class]];
}

- (NSDictionary*)dictionaryForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key]) {
        return nil;
    } else {
        NSDictionary *retDict = [self objectForKey:key];
        if ([retDict isKindOfClass:[NSDictionary class]])
            return retDict;
        else
            return nil;
    }
}

- (NSArray*)arrayForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key]) {
        return nil;
    } else {
        NSArray *retArray = [self objectForKey:key];
        if ([retArray isKindOfClass:[NSArray class]])
            return retArray;
        else
            return nil;
    }
}

- (NSInteger)integerForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] integerValue];
}

- (NSUInteger)unsignedIntegerForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] unsignedIntegerValue];
}

- (int)intForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] intValue];
}

- (unsigned int)unsignedIntForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] unsignedIntValue];
}

- (long)longForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] longValue];
}

- (unsigned long)unsignedLongForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] unsignedLongValue];
}

- (long long int)longLongIntForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] longLongValue];
}

- (unsigned long long int)unsignedLongLongIntForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0;
    else
        return [[self objectForKey:key] unsignedLongLongValue];
}

- (BOOL)boolForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return NO;
    else
        return [[self objectForKey:key] boolValue];
}

- (float)floatForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0.0;
    else
        return [[self objectForKey:key] floatValue];
}

- (double)doubleForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 0.0;
    else
        return [[self objectForKey:key] doubleValue];
}

- (double)mapCoordinateValueForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key])
        return 360.0f; // invalid coordinate
    else
        return [[self objectForKey:key] doubleValue];
}

- (NSString*)stringForKey:(NSString*)key;
{
    if([self objectForKeyIsNSNull:key]) {
        return nil;
    } else {
        NSAssert( ([self objectForKey:key] == nil) || [[self objectForKey:key] isKindOfClass:[NSString class]], @"ERROR");
        return [self objectForKey:key];
    }
}

- (id)JSONObjectForKey:(NSString*)key;
{
    NSString* text = [self stringForKey:key];
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    if(data) {
        return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    } else {
        return nil;
    }
}

- (NSDate*)dateForKey:(NSString*)key;
{
    NSTimeInterval interval = [self doubleForKey:key];
    if(interval == 0.0)
        return nil;
    else
        return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end

@implementation NSMutableDictionary (SafeAccessor)

- (void)setDate:(NSDate*)date forKey:(NSString*)key;
{
    NSTimeInterval interval = [date timeIntervalSince1970];
    if(interval == 0.0) {
        [self removeObjectForKey:key];
    } else {
        [self setValue:@(interval) forKey:key];
    }
}

@end
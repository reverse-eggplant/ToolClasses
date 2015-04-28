//
//  NSDictionary+SafeAccessor.h
//  VacationIOS
//
//  Created by 巩 鹏军 on 14-3-27.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeAccessor)

- (BOOL)objectForKeyIsNSNull:(NSString*)key;

- (NSDictionary*)dictionaryForKey:(NSString*)key;
- (NSArray*)arrayForKey:(NSString*)key;

- (NSInteger)integerForKey:(NSString*)key;
- (NSUInteger)unsignedIntegerForKey:(NSString*)key;

- (int)intForKey:(NSString*)key;
- (unsigned int)unsignedIntForKey:(NSString*)key;

- (long)longForKey:(NSString*)key;
- (unsigned long)unsignedLongForKey:(NSString*)key;

- (long long int)longLongIntForKey:(NSString*)key;
- (unsigned long long int)unsignedLongLongIntForKey:(NSString*)key;

- (BOOL)boolForKey:(NSString*)key;

- (float)floatForKey:(NSString*)key;
- (double)doubleForKey:(NSString*)key;

- (double)mapCoordinateValueForKey:(NSString*)key;

- (NSString*)stringForKey:(NSString*)key;

- (id)JSONObjectForKey:(NSString*)key;

- (NSDate*)dateForKey:(NSString*)key;

@end

@interface NSMutableDictionary (SafeAccessor)
- (void)setDate:(NSDate*)date forKey:(NSString*)key;
@end

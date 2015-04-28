//
//  NSUserDefaultManager.m
//  LightApp
//
//  Created by malong on 14/11/10.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "NSUserDefaultManager.h"

@implementation NSUserDefaultManager

+ (NSDictionary *)dictionaryRepresentation
{
    return [USER_DEFAULT dictionaryRepresentation];
}


+ (void)synchronize{
    [USER_DEFAULT synchronize];
}


@end

//
//  NSMutableArray+SafeAccessor.m
//  Baller
//
//  Created by Tongtong Xu on 15/3/23.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#import "NSMutableArray+SafeAccessor.h"

@implementation NSMutableArray (SafeAccessor)
- (void)addObjectOrNil:(id)anObject
{
    if (!anObject) {
        return;
    }
    [self addObject:anObject];
}
@end

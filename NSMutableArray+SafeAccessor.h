//
//  NSMutableArray+SafeAccessor.h
//  Baller
//
//  Created by Tongtong Xu on 15/3/23.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SafeAccessor)
- (void)addObjectOrNil:(id)anObject;
@end

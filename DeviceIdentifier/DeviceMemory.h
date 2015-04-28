//
//  DeviceMemory.h
//  LightApp
//
//  Created by malong on 14/11/17.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceMemory : NSObject

// 获取当前设备可用内存(单位：MB）
+ (double)availableMemory;

// 获取当前任务所占用的内存（单位：MB）
+ (double)usedMemory;

+ (void) logMemoryInfo;
@end

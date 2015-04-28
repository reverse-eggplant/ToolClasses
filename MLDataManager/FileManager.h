//
//  FileManager.h
//  LightApp
//
//  Created by malong on 14/11/11.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

//返回文件存储的数据
+ (NSData *)dataWithFileName:(NSString *)fileName;


//返回文件存储的字符串
+ (NSString *)stringWithFileName:(NSString *)fileName;


//返回文件存储的字典
+ (NSMutableDictionary *)dictionaryWithFileName:(NSString *)fileName;

@end

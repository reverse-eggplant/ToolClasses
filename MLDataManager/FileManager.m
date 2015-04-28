//
//  FileManager.m
//  LightApp
//
//  Created by malong on 14/11/11.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager


//返回文件存储的数据
+ (NSData *)dataWithFileName:(NSString *)fileName
{
    
    return [NSData dataWithContentsOfFile:CACHEFILEPATH(fileName)];
}

//返回文件存储的字符串
+ (NSString *)stringWithFileName:(NSString *)fileName{
    
    return [NSString stringWithContentsOfFile:CACHEFILEPATH(fileName) usedEncoding:NULL error:NULL];
}


//返回文件存储的字典
+ (NSMutableDictionary *)dictionaryWithFileName:(NSString *)fileName{
    
    return   [[NSMutableDictionary alloc]initWithContentsOfFile:CACHEFILEPATH(fileName)];
    
}

@end

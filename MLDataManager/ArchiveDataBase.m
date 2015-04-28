//
//  ArchiveDataBase.m
//  DataStore
//
//  Created by malong on 14/11/9.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "ArchiveDataBase.h"

@implementation ArchiveDataBase


+(BOOL)archiveDataWithFileName:(NSString *)fileName
                        object:(NSObject *)objData
                           key:(NSString *)key
{
    
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:objData forKey:key];
    
    [archiver finishEncoding];
    
    return [data writeToFile:CACHEFILEPATH(fileName) atomically:YES];
    
    
}


+ (id)unArchiveDataWithFileName:(NSString *)fileName
                            key:(NSString *)key
{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:CACHEFILEPATH(fileName)]) {
        DLog(@"filePAth:%@",CACHEFILEPATH(fileName));
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:CACHEFILEPATH(fileName)];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        //解档出数据模型
        NSObject * obj = [unarchiver decodeObjectForKey:key];
        [unarchiver finishDecoding];//一定不要忘记finishDecoding，否则会报错
        return obj;
    }
    return nil;
}




//归档存储数据
+(void)archiveWithtSuffix:(NSString *)suffix
                   dataSourceDic:(NSDictionary *) sourceDic
                        fileName:(NSString *)fileName
{
    [[NSFileManager defaultManager] createDirectoryAtPath:CACHEFILEPATH(@"myFolder")
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    
    NSString *strFilename= [CACHEFILEPATH(@"myFolder")
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@.dat",fileName,suffix]];
    
    [NSKeyedArchiver archiveRootObject:sourceDic toFile:strFilename];
    
}



//取缓存
+(NSDictionary *)unArchiveWithSuffix:(NSString *) suffix
                            fileName:(NSString *)fileName
{
    
    [[NSFileManager defaultManager] createDirectoryAtPath:CACHEFILEPATH(@"myFolder")
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    
    
    NSString *strFileName= [CACHEFILEPATH(@"myFolder")
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@.dat",fileName,suffix]];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:strFileName];
    if (blHave)
    {
        NSDictionary *arrNewsList = [NSDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:strFileName]];
        return arrNewsList;
    }
    else
    {
        return nil;
    }
    
}



//判断是否有缓存
+(BOOL)isHaveCachedWithSuffix:(NSString *) suffix
                     fileName:(NSString *)fileName
{
    
    [[NSFileManager defaultManager] createDirectoryAtPath:CACHEFILEPATH(@"myFolder")
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    
    NSString *strFileName= [CACHEFILEPATH(@"myFolder")
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@.dat",fileName,suffix]];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:strFileName];
    
}

@end

//
//  ArchiveDataBase.h
//  DataStore
//
//  Created by malong on 14/11/9.
//  Copyright (c) 2014年 malong. All rights reserved.
//


//归档工具类

/*
 要点：
     1、所处理数据对象要遵守NSCoding协议，该对象对应的类必须提供encodeWithCoder:和initWithCoder:方法。前一个方法告诉系统怎么对对象进行编码，而后一个方法则是告诉系统怎么对对象进行解码
     2、NSArray、NSDictionary、NSData等遵守NSSecureCoding协议的数据对象可以直接归档
 
 缺点：1、操作数据时，一次性归档保存以及一次性解压，如果想改动数据的某一小部分，还是需要解压整个数据或者归档整个数据。比较笨拙，使用不便。
      2、针对小量数据使用还行，大量数据时操作成本太高
 
 */

#import <Foundation/Foundation.h>

@interface ArchiveDataBase : NSObject


/*
 *归档当前数据对象到指定文件路径下
 */
+ (BOOL)archiveDataWithFileName:(NSString *)fileName
                         object:(NSObject *)objData
                            key:(NSString *)key;


/*
 *从指定文件路径下解档出数据对象
 */
+ (id)unArchiveDataWithFileName:(NSString *)fileName
                            key:(NSString *)key;


/*
 *归档字典到指定文件路径下
 */
+(void)archiveWithtSuffix:(NSString *) suffix
            dataSourceDic:(NSDictionary *) sourceDic
                 fileName:(NSString *)fileName;


/*
 *从指定文件路径下解档出字典对象
 */
+(NSDictionary *)unArchiveWithSuffix:(NSString *) suffix
                            fileName:(NSString *)fileName;



/*
 *判断是否已缓存
 */
+(BOOL)isHaveCachedWithSuffix:(NSString *) suffix
                     fileName:(NSString *)fileName;


@end

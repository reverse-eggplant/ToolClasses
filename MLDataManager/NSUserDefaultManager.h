//
//  NSUserDefaultManager.h
//  LightApp
//
//  Created by malong on 14/11/10.
//  Copyright (c) 2014年 malong. All rights reserved.
//

//NSUserDefaults管理类

/*
 1、NSUserDefaults可以存储的数据类型包括：NSData、NSString、NSNumber、NSDate、NSArray、NSDictionary。
 2、如果想存储其他类型的对象，你要将其归档并创建一个NSData来实现存储。
 3、从NSUserDefaults返回的值是不可改变的。
 4、NSUserDefaults是单例，同时也是线程安全的
 
 扩展阅读：http://www.360doc.com/content/13/1225/15/8310724_340020081.shtml
 
 */

#import <Foundation/Foundation.h>

@interface NSUserDefaultManager : NSObject

//获取设备上的所有的NSUserDefaults的设置
+ (NSDictionary *)dictionaryRepresentation;

//将设置同步存到默认参数中，使内存中的缓存与用户默认系统进行同步。
+ (void)synchronize;


@end

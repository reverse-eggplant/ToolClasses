//
//  DataBaseManager.h
//  LightApp
//
//  Created by malong on 14/11/13.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseAdditions.h"


typedef enum{
    kDBCREATEFAILURE = -1,     //创建失败
    kDBHASEXSIT = 0,            //已经存在
    kDBCREATESUCCESS = 1        //创建成功
    
}DBTYPE;


@class FMDatabase;

/**
 * @brief 对本地数据链接进行操作管理，建立链接和关闭连接
 */

@interface DataBaseManager : NSObject
{
    NSString * _dataBasePath;  //数据库路径
}

@property (nonatomic, readonly) FMDatabase * dataBase;  // 数据库操作对象，数据库建立后，存在此处


+(DataBaseManager *) defaultDataBaseManager;


- (void) close;  // 关闭数据库


/**
 * @brief 创建数据库
 */
+ (void) createDataBaseWithDBModel:(NSObject *)dbModel;



/**
 * @brief 保存一条用户记录
 *
 * @param dbModel 需要保存的数据模型
 */
+ (void) saveDataWithMDBModel:(NSObject *) dbModel;



/**
 * @brief 删除一条用户数据
 *
 * @param modelName 需要删除的数据模型的名称
 * @param keyName   需要删除的数据模型的主键名称
 * @param keyValue  需要删除的数据模型的主键值
 */
+ (void) deleteDataModelWithModelName:(NSString *)modelName
                              keyName:(NSString *)keyName
                             keyValue:(id) keyValue;



/**
 * @brief 以keyName为查询条件，更新主键值为keyValue的数据对象的值
 *
 * @param dbModel 所要修改的数据源
 */
+ (void) mergeWithDBModel:(NSObject *)dbModel
                    keyName:(NSString *)keyName
                   keyValue:(id) keyValue;



/**
 * @brief 模拟分页查找数据。取modelId大于某个值以后的limit个数据
 *
 * @param modelName 需要查询的数据模型的名称
 * @param keyName   需要删除的数据模型的主键名称
 * @param keyValue  需要删除的数据模型的主键值
 * @param limit 每页取多少个
 */
+ (NSArray *) findWithModelName:(NSString *)modelName
                        keyName:(NSString *) keyName
                       keyValue:(id)keyValue
                          limit:(int) limit;



@end

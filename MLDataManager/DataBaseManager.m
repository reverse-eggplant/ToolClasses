//
//  DataBaseManager.m
//  LightApp
//
//  Created by malong on 14/11/13.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDatabase.h"
#import "NSObject+DateBaseModel.h"

#define kDefaultDataBaseName @"LightApp.sqlite"

@implementation DataBaseManager

static DataBaseManager * _defaultDataBaseManager = nil;
static dispatch_once_t once = 0;

+(DataBaseManager *) defaultDataBaseManager{
    
    dispatch_once(&once, ^{
        _defaultDataBaseManager = [[DataBaseManager alloc] init];
        
    });
    return _defaultDataBaseManager;

}

- (void) dealloc {
    [self close];
}

- (id) init {
    
    self = [super init];
    
    if (self) {
        int state = [self initializeDBWithName:kDefaultDataBaseName];
        
        if (state == kDBCREATEFAILURE) {
            DLog(@"数据库初始化失败");
        } else {
            DLog(@"数据库初始化成功");
        }
    }
    return self;
}

/**
 * @brief 初始化数据库操作
 * @param name 数据库名称
 * @return 返回数据库初始化状态，
 */

- (int) initializeDBWithName : (NSString *) name {
    if (!name) {
        return kDBCREATEFAILURE;  // 返回数据库创建失败
    }
    // 沙盒Docu目录
    NSString * filePath = [NSString stringWithFormat:@"/%@",name];
    _dataBasePath = DOCUMENTFILEPATH(filePath);
    
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:_dataBasePath];
    [self connect];
    if (!exist) {
        return kDBHASEXSIT;
    } else {
        return kDBCREATESUCCESS;
    }
    
}



/// 连接数据库
- (void) connect {
    
    if (!_dataBase) {
        _dataBase = [[FMDatabase alloc] initWithPath:_dataBasePath];
    }
    if (![_dataBase open]) {
        DLog(@"不能打开数据库");
    }
}
/// 关闭连接
- (void) close {
    [_dataBase close];
    _defaultDataBaseManager = nil;
}


#pragma mark 数据库操作方法

+ (void) createDataBaseWithDBModel:(NSObject *)dbModel
{
    
    NSString * modelClassName = NSStringFromClass([dbModel class]);
    
    FMResultSet * set = [[[[self class] defaultDataBaseManager] dataBase] executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",modelClassName]];
    
    [set next];
    
    NSInteger count = [set intForColumnIndex:0];
    
    BOOL existTable = !!count;
    
    if (existTable) {
        // TODO:是否更新数据库
//        [AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
    } else {
        // TODO: 插入新的数据库
        
        NSMutableString * sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",modelClassName];
        
        for (NSString *  propertyName in dbModel.propertyNames) {
            [sql appendFormat:@"%@,",propertyName];
        }
        [sql appendFormat:@")"];
        
        
        
        BOOL res = [[[[self class] defaultDataBaseManager] dataBase] executeUpdate:[sql stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
        if (!res) {
//            [AppDelegate showStatusWithText:@"数据库创建失败" duration:2];
        } else {
//            [AppDelegate showStatusWithText:@"数据库创建成功" duration:2];
        }
    }
}


/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
+ (void) saveDataWithMDBModel:(NSObject *) dbModel
{
    [[[[self class] defaultDataBaseManager] dataBase]open];

    NSString * modelClassName = NSStringFromClass([dbModel class]);

    //编辑插入语句
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO %@",modelClassName];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:dbModel.propertyNames.count];
    
    //遍历数组并将数组属性名称拼接
    for (NSString * propertyName in dbModel.propertyNames) {
        [keys appendString:[NSString stringWithFormat:@"%@,",propertyName]];
        [values appendString:@"?,"];
        //添加数据
        if ([dbModel valueForKey:propertyName]) {
            [arguments addObject:[dbModel valueForKey:propertyName]];
        }else{
            [arguments addObject:[NSNull new]];
        }

    }

    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    DLog(@"%@",query);
//    [AppDelegate showStatusWithText:@"插入一条数据" duration:2.0];
    [[[[self class] defaultDataBaseManager] dataBase] executeUpdate:query withArgumentsInArray:arguments];
    
    [[[[self class] defaultDataBaseManager] dataBase]close];

}


/**
 * @brief 删除一条用户数据
 *
 * @param modelName 需要删除的数据模型的名称
 * @param keyName   需要删除的数据模型的主键名称
 * @param keyValue  需要删除的数据模型的主键
 */
+ (void) deleteDataModelWithModelName:(NSString *)modelName
                              keyName:(NSString *)keyName
                             keyValue:(id) keyValue
{
    [[[[self class] defaultDataBaseManager] dataBase]open];

    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %@",modelName,keyName,keyValue];
    DLog(@"%@",query);
    

    if ([[[[self class] defaultDataBaseManager] dataBase] executeUpdate:query])
//        [AppDelegate showStatusWithText:@"删除数据成功" duration:2.0];
    
    [[[[self class] defaultDataBaseManager] dataBase]close];

}


/**
 * @brief 以keyName为查询条件，更新主键值为keyValue的数据对象的值
 *
 * @param dbModel 所要修改的数据源
 */
+ (void) mergeWithDBModel:(NSObject *)dbModel
                  keyName:(NSString *)keyName
                 keyValue:(id) keyValue
{
    [[[[self class] defaultDataBaseManager] dataBase]open];
    
    NSString * modelClassName = NSStringFromClass([dbModel class]);

    NSMutableString * query = [NSMutableString stringWithFormat:@"UPDATE %@ SET",modelClassName];
    NSMutableArray * arguments = [NSMutableArray array];
    
    //遍历对象的属性数组，并从新赋值
    for (NSString *  propertyName in dbModel.propertyNames) {
        if ([dbModel valueForKey:propertyName]) {
            [query appendFormat:@" %@ =  ?,",propertyName];
            [arguments addObject:[dbModel valueForKey:propertyName]];

        }
    }
    [query appendString:@")"];
    [query appendFormat:@" WHERE %@ = ?",keyName];
    [arguments addObject:keyValue];

    NSString * sql = [NSString stringWithFormat:@"%@",query];
    sql = [sql stringByReplacingOccurrencesOfString:@",)" withString:@""];
    DLog(@"%@",sql);
    
   
    if([[[[self class] defaultDataBaseManager] dataBase] executeUpdate:sql withArgumentsInArray:arguments])
//         [AppDelegate showStatusWithText:@"成功修改了数据" duration:2.0];
    
    [[[[self class] defaultDataBaseManager] dataBase]close];

}


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
                          limit:(int) limit
{
    [[[[self class] defaultDataBaseManager] dataBase]open];

    if (!keyName) {
//        [AppDelegate showStatusWithText:@"缺少查询条件！" duration:2.0];
        return nil;
    }
    
    
    NSMutableString * temp = [NSMutableString stringWithFormat:@"SELECT "];
    NSObject * dbModel = [[NSClassFromString(modelName) alloc]init];
    //遍历对象的属性数组，拼接查询语句
    for (NSString *  propertyName in dbModel.propertyNames) {
        [temp appendFormat:@"%@,",propertyName];
    }
    [temp appendString:@")"];
    
    
    NSMutableString * temp2 = [NSMutableString stringWithFormat:@"%@",[temp stringByReplacingOccurrencesOfString:@",)" withString:@" "]];
    [temp2 appendFormat:@"FROM %@",modelName];
    
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"%@",[temp2 stringByAppendingFormat:@" WHERE %@ = ? ORDER BY %@ DESC limit %d",keyName,keyName,limit]];
    
    NSMutableArray * arguments = [NSMutableArray array];
    [arguments addObject:keyValue];
    DLog(@"%@",query);

    //根据查询语句查询
    FMResultSet * set = [[[[self class] defaultDataBaseManager] dataBase] executeQuery:query withArgumentsInArray:arguments];
    NSMutableArray * results = [NSMutableArray arrayWithCapacity:[set columnCount]];
    
    
    //根据查询结果，生成对象，放入数组并返回
    while ([set next]) {
        
        NSObject * obj = [[NSClassFromString(modelName) alloc]init];
        
        for (NSString *  propertyName in obj.propertyNames) {
            [obj setValue:[set objectForColumnName:propertyName] forKey:propertyName];
        }
        
        [results addObject:obj];
        
    }
    [set close];
    DLog(@"results.count = %lu",(unsigned long)results.count);
    
    [[[[self class] defaultDataBaseManager] dataBase]close];

    return results;
    

}

@end

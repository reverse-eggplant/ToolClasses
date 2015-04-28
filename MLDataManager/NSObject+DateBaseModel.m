//
//  NSObject+DateBaseModel.m
//  LightApp
//
//  Created by malong on 14/11/15.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "NSObject+DateBaseModel.h"

@implementation NSObject (DateBaseModel)

- (NSDictionary *)propertiesDic {

    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
    
//    return [self dictionaryWithValuesForKeys:[self propertyNames]];
}


- (NSMutableArray*)propertyNames{
    
    unsigned int outCount, i;
    
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray * propertyNames = [NSMutableArray arrayWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [propertyNames addObject:propertyName];
        
    }
    
    free(properties);
    return propertyNames;
}



- (NSMutableArray *)propertyVaules{
    
    NSMutableArray * propertyNames = [self propertyNames];
    NSMutableArray * propertyVaules = [NSMutableArray arrayWithCapacity:propertyNames.count];
    
    for (int i = 0; i<propertyNames.count; i++) {
        
        id propertyValue = [self valueForKey:[propertyNames objectAtIndex:i]];
        
        if (nil != propertyValue) {
            [propertyVaules addObject:propertyValue];
        }
    }
    
    return propertyVaules;
//    return [[self propertiesDic] allValues];
}


/**
 * @brief 获取对象的所有方法信息
 */
-(NSArray *)mothodLists
{
    unsigned int mothCout =0;
    
    //获取方法列表
    Method* methodList = class_copyMethodList([self class],&mothCout);
    
    //创建存储方法信息的数组
    NSMutableArray * methodlists = [NSMutableArray array];
    
    //遍历数组，提取每个方法的信息
    for(int i=0;i<mothCout;i++)
    {
        //获取方法
        Method method = methodList[i];
//        IMP imp_f = method_getImplementation(temp_f);
//        SEL name_f = method_getName(temp_f);
        
        //创建方法信息字典
        NSMutableDictionary * methodInfo = [NSMutableDictionary dictionary];
        
        
        //获取方法名
        const char * name =sel_getName(method_getName(method));
        NSString * methodName = [NSString stringWithUTF8String:name];
        [methodInfo setValue:methodName forKey:@"methodName"];
        
        
        //获取方法返回值类型
        const char * returnType = method_copyReturnType(method);
        NSString * returnTypeString = [NSString stringWithUTF8String:returnType];
        [methodInfo setValue:returnTypeString forKey:@"returnTypeString"];

        
        //获取方法参数个数、每个参数的类型
        int arguments = method_getNumberOfArguments(method);
        if (arguments) {
            //创建存储参数类型名的数组
            NSMutableArray * methodArgumentTypes = [NSMutableArray array];
            
            for (int j = 0; j<arguments; j++) {
                //获取每个参数的类型
                char argumentType[256];
                
                method_getArgumentType(method, j, argumentType, 256);
                
                NSString * argumentTypeName = [NSString stringWithUTF8String:argumentType];
                [methodArgumentTypes addObject:argumentTypeName];
            }
            
            [methodInfo setObject:methodArgumentTypes forKey:@"methodArgumentTypes"];
        }
        
        
        //获取方法编码格式
        const char* encoding = method_getTypeEncoding(method);
        NSString * encodingName = [NSString stringWithUTF8String:encoding];
        [methodInfo setValue:encodingName forKey:@"encodingName"];

        
        
        DLog(@"方法名：%@,参数个数：%d,编码方式：%@",methodName,
              arguments,
              [NSString stringWithUTF8String:encoding]);
        
        [methodlists addObject:methodInfo];
        
    }
    
    free(methodList);
    
    return methodlists;
}


@end

//
//  NSObject+DateBaseModel.h
//  LightApp
//
//  Created by malong on 14/11/15.
//  Copyright (c) 2014年 malong. All rights reserved.
//


/*
 runtime是什么:运行时刻是指一个程序在运行（或者在被执行）的状态。 Runtime类封装了运行时的环境。它属于C语言库, 有很多底层的C语言API。
 要点：1、不能实例化一个Runtime对象
      2、可以通过 getRuntime 方法获取当前Runtime运行时对象的引用
 
runtime可以干什么？
runtime是属于OC的底层, 可以进行一些非常底层的操作(用OC是无法现实的, 不好实现)
 在程序运行过程中, 动态创建一个类(比如KVO的底层实现)、动态地为某个类添加属性\方法, 修改属性值\方法
 遍历一个类的所有成员变量(属性)\所有方法

 
 相关链接：http://blog.csdn.net/volcan1987/article/details/8890245
 
 典型例子：KVO的底层实现
 
 */
#import <Foundation/Foundation.h>
#import <objc/runtime.h>


/**
 * @brief 数据库模型类目
 */

@interface NSObject (DateBaseModel)

/**
 * @brief 属性列表
 */
- (NSDictionary *)propertiesDic;

/**
 * @brief 属性列表名数组
 */
- (NSMutableArray*)propertyNames;


/**
 * @brief 属性对应值数组
 */
- (NSMutableArray*)propertyVaules;


/**
 * @brief 获取对象的所有方法信息
 */
-(NSArray *)mothodLists;

@end

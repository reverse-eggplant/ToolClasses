//
//  TimeManager.h
//  LightApp
//
//  Created by malong on 14/12/1.
//  Copyright (c) 2014年 malong. All rights reserved.
//
/*
 *brief 时间戳管理
 */
#import <Foundation/Foundation.h>

@interface TimeManager : NSObject
/*
 *brief 编辑返回一个有效的时间字符串
 */
+ (NSString *)userfulTimeString:(NSString *)timeString;

/*
 *brief 当前时间距创建时间的时间间隔
 *param createTime创建的时间
 *formatString 时间格式
 */
+ (NSString *)theInterValTimeFromCreateTime:(NSString *)createTime
                               formatString:(NSString *)formatString;

//2015-03-22格式字符串
+ (NSString *)standardDateStringWithMonthAndDay:(NSDate *)date;

//日月格式字符串
+ (NSString *)dateStringWithMonthAndDay:(NSDate *)date;


//计算跟当前时间的先后关系
+ (BOOL)theSuccessivelyWithCurrentTimeFrom:(unsigned long long)createTime;
/*
 *brief 比较时间是否比当前时间早
 *param timeString 时间
 *formatString 时间格式
 */
+ (BOOL) isTimeOlderThanCurrentTime:(NSString *)timeString
                       formatString:(NSString *)formatString;


/*
 *brief 比较两时间
 *param time1String 第一个时间
 *param time2String 第二个时间
 *formatString 时间格式
 */
+ (BOOL) isTime1:(NSString *)time1String
  orderThanTime2:(NSString *)time2String
    formatString:(NSString *)formatString;

/*
 *brief 倒计时
 */
+ (NSString *)lastTime:(NSDate *)lockDate;


#pragma mark 获取本月，本周，本季度第一天的时间戳
+ (unsigned long long)getFirstDayOfWeek:(unsigned long long)timestamp;
+ (unsigned long long)getFirstDayOfQuarter:(unsigned long long)timestamp;
+ (unsigned long long)getFirstDayOfMonth:(unsigned long long)timestamp;

#pragma mark 获取时间字符串
/*!
 *  @brief  标准时间
 */
+ (NSString *)getDateStringOfTimeInterval:(unsigned long long)timeInterval;

/*!
 *  @brief  点格式时间
 */
+ (NSString *)getPointStringOfTimeInterval:(unsigned long long)timeInterval;

/*!
 *  @brief  获取HH:mm 时间
 */
+ (NSString *)getHourAndMiniteStringOfTimeInterval:(unsigned long long)timeInterval;


@end

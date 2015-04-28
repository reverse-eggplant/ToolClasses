//
//  TimeManager.m
//  LightApp
//
//  Created by malong on 14/12/1.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "TimeManager.h"

@implementation TimeManager

+ (NSString *)userfulTimeString:(NSString *)timeString{
    return [[timeString stringByReplacingOccurrencesOfString:@"T" withString:@" "] stringByReplacingOccurrencesOfString:@"+08:00" withString:@""];
}


+ (NSString *)theInterValTimeFromCreateTime:(NSString *)createTime
                               formatString:(NSString *)formatString
{
    createTime = [[self class] userfulTimeString:createTime];
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatString?:@"yyyy-MM-dd HH:mm:ss"];
    
    //两个日期对象
    NSDate *currentTime=[dateFormatter dateFromString:
                         [dateFormatter stringFromDate:[[NSDate alloc] init]]];
//    DLog(@"currentTime = %@",currentTime);
    
    NSDate *cTime=[dateFormatter dateFromString:createTime];
//    DLog(@"cTime = %@",cTime);
    NSTimeInterval time=[currentTime timeIntervalSinceDate:cTime];
    
    //间隔日期
    NSInteger days = time/(3600*24);
    NSInteger hours =  time/(3600);
    NSInteger minites =  time/60;
//    DLog(@"components = %f",time);
    if (days >= 7) {
        NSString * tempStr = [dateFormatter stringFromDate:cTime];
        return [tempStr substringToIndex:10];
    }else if (days){
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }else if (hours){
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }else if(minites){
        return [NSString stringWithFormat:@"%ld分钟前",(long)minites];
    }
    return @"刚发布";
}

//2015-03-22格式字符串
+ (NSString *)standardDateStringWithMonthAndDay:(NSDate *)date
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


//日月格式字符串
+ (NSString *)dateStringWithMonthAndDay:(NSDate *)date
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



//计算跟当前时间的先后关系
+ (BOOL)theSuccessivelyWithCurrentTimeFrom:(unsigned long long)createTime
{
    unsigned long long currentInterval;
    NSDate * currentDate = [NSDate date];
    currentInterval = [currentDate timeIntervalSince1970];
    return createTime > currentInterval;
}

+ (BOOL) isTimeOlderThanCurrentTime:(NSString *)timeString
                       formatString:(NSString *)formatString
{
    timeString = [[self class] userfulTimeString:timeString];

    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:formatString?:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *inputDate=[df dateFromString:timeString];
    NSLog(@"inputDate =%@",inputDate);
    
    NSDate * currentDate = [NSDate date];
    NSString * currentFateString = [df stringFromDate:currentDate];
    NSDate *standardCurrentDate=[df dateFromString:currentFateString];
    NSLog(@"standardCurrentDate =%@",standardCurrentDate);
    
    switch ([inputDate compare:currentDate]) {
        case NSOrderedSame:
//            DLog(@"相等");
            return NO;
            break;
        case NSOrderedAscending:
//            DLog(@"date1比date2小");
            return YES;
            break;
        case NSOrderedDescending:
//            DLog(@"date1比date2大");
            return NO;
            break;
        default:
            return NO;
            break;
    }
    return YES;
    
}


+ (BOOL) isTime1:(NSString *)time1String
  orderThanTime2:(NSString *)time2String
    formatString:(NSString *)formatString
{
    time1String = [[self class] userfulTimeString:time1String];
    time2String = [[self class] userfulTimeString:time2String];

    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:formatString?:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date1=[df dateFromString:time1String];
    NSLog(@"date1 =%@",date1);
    if (time1String && date1 == nil) {
        return NO;
    }
    
    NSDate *date2=[df dateFromString:time2String];
    NSLog(@"date2 =%@",date2);
    
    if (time2String && date2 == nil) {
        return NO;
    }
    
    switch ([date1 compare:date2]) {
        case NSOrderedSame:
//            DLog(@"相等");
            return NO;
            break;
        case NSOrderedAscending:
//            DLog(@"date1比date2小");
            return YES;
            break;
        case NSOrderedDescending:
//            DLog(@"date1比date2大");
            return NO;
            break;
        default:
            return NO;
            break;
    }
    return YES;
    
}


+ (NSString *)lastTime:(NSDate *)lockDate
{
    NSDate *currentDate = [[NSDate alloc] init];
    //获得两个日期之间的间隔
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [gregorian
                                    components:unitFlags
                                    fromDate:currentDate
                                    toDate:lockDate
                                    options:0];
    
    NSInteger minites = [components minute];
    NSInteger seconds = [components second];
    
    //编辑锁定栏且启动计时
    if (minites>0 || seconds >= 0) {
        
        if (seconds >= 10)return [NSString stringWithFormat:
                                  @"0%ld:%ld",(long)minites,(long)seconds];
        
        else return [NSString stringWithFormat:
                     @"0%ld:0%ld",(long)minites,(long)seconds];
    }
    return nil;
}


#pragma mark 获取本月，本周，本季度第一天的时间戳
+ (unsigned long long)getFirstDayOfWeek:(unsigned long long)timestamp
{
    NSDate *now = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal
                               components:NSYearCalendarUnit| NSMonthCalendarUnit| NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit
                               fromDate:now];
    if (comps.weekday <2)
    {
        if (!IOS7) {
            comps.weekOfYear = comps.weekOfYear-1;
        }
    }
    comps.weekday = 2;
    NSDate *firstDay = [cal dateFromComponents:comps];
    return [firstDay timeIntervalSince1970];
}

+ (unsigned long long)getFirstDayOfQuarter:(unsigned long long)timestamp
{
    NSDate *now = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal
                               components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                               fromDate:now];
    if (comps.month <=3)
    {
        comps.month =  1;
    }
    else if(comps.month<=6)
    {
        comps.month =  4;
    }
    else if(comps.month<=9)
    {
        comps.month =  7;
    }
    else if(comps.month<=12)
    {
        comps.month =  10;
    }
    
    comps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    return [firstDay timeIntervalSince1970]*1000;
}

+ (unsigned long long)getFirstDayOfMonth:(unsigned long long)timestamp
{
    NSDate *now = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal
                               components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                               fromDate:now];
    comps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    return [firstDay timeIntervalSince1970]*1000;
}

#pragma mark 获取时间字符串

+(NSString *)getDateStringOfTimeInterval:(unsigned long long)timeInterval{
    NSDate * targerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter * dataFormater = [[NSDateFormatter alloc]init];
    [dataFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dataFormater stringFromDate:targerDate];
}

+ (NSString *)getPointStringOfTimeInterval:(unsigned long long)timeInterval
{
    return [[[[self class] getDateStringOfTimeInterval:timeInterval] substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
}

+ (NSString *)getHourAndMiniteStringOfTimeInterval:(unsigned long long)timeInterval{
    
    NSDate * targerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter * dataFormater = [[NSDateFormatter alloc]init];
    [dataFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString * timeString = [[dataFormater stringFromDate:targerDate] substringFromIndex:11];
    if ([[timeString substringToIndex:2] integerValue]<=12) {
        timeString = [timeString stringByAppendingString:@" AM"];
    }else{
        timeString = [timeString stringByAppendingString:@" PM"];
    }
    return timeString;
}

@end

//
//  NSStringManager.h
//  LightApp
//
//  Created by malong on 14/12/1.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSStringManager : NSObject

/*
 *brief:根据字号大小和范围，获取字符串的尺寸
 *param size 视图区间
 */
+ (CGSize) sizeOfCurrentString:(NSString *)aString
                          font:(float)fontSize
                   contentSize:(CGSize)size;


/*
 *brief:根据字号大小和范围，获取字符串的尺寸
 *param size 视图区间
 *fontname 字体名称
 */
+ (CGSize) sizeOfCurrentString:(NSString *)aString
                          font:(float)fontSize
                   contentSize:(CGSize)size
                      WithName:(NSString*)fontname;

/*!
 *  @brief  获取一个只变色，不变字体大小的字符串
 *
 *  @param text1   第一个要关键字符串
 *  @param color1  第一个关键字符串的颜色
 *  @param text2   第二个要关键字符串
 *  @param color2  第二个关键字符串的颜色
 *  @param allText 全字符串
 *
 *  @return 
 */
+(NSMutableAttributedString *)getAcolorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Text2:(NSString *)text2 Color2:(UIColor *)color2 AllText:(NSString *)allText;


/*!
 *  @brief  获取变色、变字体大小的字符串
 *

 *  @param text1   第一个要关键字符串
 *  @param font1   第一个字符串的字体
 *  @param color1  第一个关键字符串的颜色
 *  @param text2   第二个要关键字符串
 *  @param font2   第二个关键字字体
 *  @param color2  第二个关键字符串的颜色
 *  @param allText 全字符串
 
 */
+(NSMutableAttributedString *)getAcolorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Font1:(UIFont *)font1 Text2:(NSString *)text2 Color2:(UIColor *)color2 Font2:(UIFont *)font2 AllText:(NSString *)allText;

@end

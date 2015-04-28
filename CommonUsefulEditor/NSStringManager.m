//
//  NSStringManager.m
//  LightApp
//
//  Created by malong on 14/12/1.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "NSStringManager.h"

@implementation NSStringManager

//字符串尺寸
+ (CGSize) sizeOfCurrentString:(NSString *)aString
                          font:(float)fontSize
                   contentSize:(CGSize)size
{
    if (aString == nil || aString.length == 0) {
        return CGSizeZero;
    }
    
    NSRange range = NSMakeRange(0, aString.length);
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:aString];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range];
    CGSize stringSize = [aString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[attri attributesAtIndex:0 effectiveRange:&range] context:nil].size;

    return stringSize;
    
}

+ (CGSize) sizeOfCurrentString:(NSString *)aString
                          font:(float)fontSize
                   contentSize:(CGSize)size
                      WithName:(NSString*)fontname
{
    
    if (aString == nil || aString.length == 0) {
        return CGSizeZero;
    }
    
    NSRange range = NSMakeRange(0, aString.length);
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:aString];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontname size:fontSize] range:range];
    CGSize stringSize = [aString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[attri attributesAtIndex:0 effectiveRange:&range] context:nil].size;
        return stringSize;
}


+(NSMutableAttributedString *)getAcolorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Text2:(NSString *)text2 Color2:(UIColor *)color2 AllText:(NSString *)allText
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allText];
    [str beginEditing];
    if (text1) {
        NSRange range1 = [allText rangeOfString:text1];
        if (color1) {
            [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color1 range:range1];

        }
    }
    
    if (text2) {
        NSRange range2 = [allText rangeOfString:text2];
        if (color2) {
            [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color2 range:range2];

        }
    }
    
    
    [str endEditing];
    
    return str;
}

+(NSMutableAttributedString *)getAcolorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Font1:(UIFont *)font1 Text2:(NSString *)text2 Color2:(UIColor *)color2 Font2:(UIFont *)font2 AllText:(NSString *)allText
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allText];
    [str beginEditing];
    if (text1) {
        NSRange range1 = [allText rangeOfString:text1];
        if (color1) {
            [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color1 range:range1];
 
        }
        if (font1) {
            [str addAttribute:NSFontAttributeName value:font1 range:range1];
            
        }
    }
    
    if (text2) {
        NSRange range2 = [allText rangeOfString:text2];
        if (color2) {
            [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color2 range:range2];

        }
        if (font2) {
            [str addAttribute:NSFontAttributeName value:font2 range:range2];
            
        }
    }
    
    [str endEditing];
    
    return str;
}


@end

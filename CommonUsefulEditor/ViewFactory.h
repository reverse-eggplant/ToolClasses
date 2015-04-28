//
//  ViewFactory.h
//  LightApp
//
//  Created by malong on 14/11/26.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewFactory : NSObject


/*
 *brief:获取一个透明视图
 */
+ (UIView *)clearViewWithFrame:(CGRect)frame;


/*
 *brief:获取一个自定义的UIBarButtonItem
 *param imageName 按钮图片名称
 *param edeInsets 图片偏移设置
 *param target    按钮方法执行target
 *param selectAction 按钮方法
 */
+ (UIBarButtonItem *)getABarButtonItemWithImage:(NSString *)imageName
                                imageEdgeInsets:(UIEdgeInsets)edgeInsets
                                         target:(id)target
                                      selection:(SEL)selectAction;

+ (UIBarButtonItem *)getABarButtonItemWithTitle:(NSString *)title
                                titleEdgeInsets:(UIEdgeInsets)edgeInsets
                                         target:(id)target
                                      selection:(SEL)selectAction;

/*
 *brief:给某个试图生成一个标签
 *param aView 要添加到的视图
 *param labelText 标签文案
 *param labelFrame  标签frame
 *param labelColor  标签文案颜色
 */
+ (UILabel *)addAlabelForAView:(UIView *)aView
                      withText:(NSString *)labelText
                         frame:(CGRect)labelFrame
                          font:(UIFont *)labelFont
                     textColor:(UIColor *)labelColor;


/*
 *brief:获取一个按钮
 *param nImage 设置正常状态下按钮的image
 *param hImage 设置高亮状态下按钮的image
 */
+ (UIButton *)getAButtonWithFrame:(CGRect)frame
                       nomalTitle:(NSString *)nomalTitle
                          hlTitle:(NSString *)hlTitle
                       titleColor:(UIColor *)tColor
                          bgColor:(UIColor *)bgColor
                           nImage:(NSString *)nImage
                           hImage:(NSString *)hImage
                           action:(SEL)selector
                           target:(id)target
                       buttonTpye:(UIButtonType)theButtodnTpye;



/*
 *brief:获取一个输入框
 *param imageName 输入框左侧视图
 */
+ (UITextField *)getATFWithFrame:(CGRect)frame
                        delegate:(id)delegate
                     palceHolder:(NSString *)placeHolder
               leftViewImageName:(NSString *)imageName;

//给视图添加上、下线
+ (UIView *)addLineToView:(UIView *)view frame:(CGRect)frame color:(UIColor *)lineColor;

//给视图添加layer
+ (CALayer *)addLayerToView:(CALayer *)layer
                      frame:(CGRect)frame
                 layerColor:(UIColor *)layerColor;

@end

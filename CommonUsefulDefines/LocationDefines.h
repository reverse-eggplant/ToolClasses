//
//  LocationDefines.h
//  Baller
//
//  Created by malong on 15/1/9.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#ifndef Baller_LocationDefines_h
#define Baller_LocationDefines_h

#pragma mark 屏幕宽高等

#define NUMBER(number_6p,number_6,number_5,number_4) (IPHONE6P?number_6p:(IPHONE6?number_6:(IPHONE5?number_5:number_4)))

//屏幕宽高等。
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height


#define IPHONE4  ScreenHeight == 480

#define IPHONE5  ScreenHeight == 568

#define IPHONE6  ScreenWidth == 375

#define IPHONE6P ScreenWidth == 414

#define NavigationBarHeight     64.0
#define StatusBarHeight     20.0
#define TabBarHeight     49.0

#define PersonInfoCell_Height     (NUMBER(80.0,72.0,65.0,65.0))

//个人球员卡、个人信息界面地图圆角参数
#define TextFontSize (NUMBER(17.0, 16.0, 14.5, 14.5)) 
#define HeadLayer_BorderWidth NUMBER(4.0, 4.0, 4.0, 4.0)      //背景层圆角
#define HeadLayer_CircleRadius NUMBER(65.0, 60.0, 55.0, 55.0)  //头像半径

#define BackLayer_SimicircleRadius NUMBER(66.5, 61.5, 56.5, 56.5)  //半圆半径
#define BackLayer_CornerRadius NUMBER(31.0, 28.0, 25.0, 25.0)      //背景层圆角

#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

#define TABLE_SPACE_INSET NUMBER(15.0, 12.0, 8.0, 8.0)//列表边距
#define TABLE_CORNERRADIUS NUMBER(10.0, 9.0, 7.0, 7.0)  //列表圆角

//首页item的间隔
#define BallPark_ItemSpacing NUMBER(14.0, 12.0, 10., 10.0)

//球员列表展示页item的上下间隔
#define Baller_BPAttention_ItemVerSpacing NUMBER(18.0, 17.0, 16.0, 15.0)

#endif

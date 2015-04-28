//
//  ColorDefines.h
//  Baller
//
//  Created by malong on 15/1/8.
//  Copyright (c) 2015年 malong. All rights reserved.
//

// 颜色设置
#define CLEARCOLOR [UIColor clearColor]

//十六进制方式设置rgb
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define RGBAColor(r,g,b,a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) RGBAColor(r,g,b,1.0f)

//常用颜色
#define BLUE UIColorFromRGB(0X2b75ba)
#define DARK UIColorFromRGB(0X141F40)
#define GRAY UIColorFromRGB(0X808080)
#define CYAN_COLOR UIColorFromRGB(0X2c3d51)   //青色
#define BALLER_CORLOR_696969 UIColorFromRGB(0X696969)
#define BALLER_CORLOR_767676 UIColorFromRGB(0X767676)
#define BALLER_CORLOR_b2b2b2 UIColorFromRGB(0Xb2b2b2)
#define BALLER_CORLOR_5c5c5c UIColorFromRGB(0X5c5c5c)
#define BALLER_CORLOR_CELL UIColorFromRGB(0Xeceff4)  //列表灰
#define BALLER_CORLOR_NAVIGATIONBAR UIColorFromRGB(0X2C3D51)  //列表灰
#define BALLER_CORLOR_RED UIColorFromRGB(0x542120)

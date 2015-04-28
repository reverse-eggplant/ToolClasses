//
//  SourcesDefines.h
//  Baller
//
//  Created by malong on 15/1/8.
//  Copyright (c) 2015年 malong. All rights reserved.
//


//资源

#define IMAGE_FILE(imageName,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:type]]
#define LOADPNGIMAGE(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:@"png"]]

#define IMAGE_PNG(name)       [UIImage imageNamed:name]

#define kPathOFXMLResource(name)    [[NSBundle mainBundle] pathForResource:(name) ofType:@"xml"]

#define kPathOFPLISTResource(name)    [[NSBundle mainBundle] pathForResource:(name) ofType:@"plist"]

#define kPathOFResourceOfType(res, type)    [[NSBundle mainBundle] pathForResource:(res) ofType:(type?type:nil)]

// 文件及其他资源路径

#define DEFAULTFILEMANAGER [NSFileManager defaultManager]       //文件管理器

#define CACHEFILEPATH(fileName) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName]  //缓存路径

#define DOCUMENTFILEPATH(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName]  //文件目录路径

#define ISFILEEXIST(filePath) [DEFAULTFILEMANAGER fileExistsAtPath:filePath]  //判断文件是否存在


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]  //实例化




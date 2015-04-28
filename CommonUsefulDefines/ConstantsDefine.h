//
//  ConstantsDefine.h
//  LightApp
//
//  Created by malong on 14/11/5.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "SourcesDefines.h"
#import "ColorDefines.h"
#import "BlockDefines.h"
#import "LocationDefines.h"
#import "FontDefines.h"
#import "ViewDefines.h"
#import "SystemDefines.h"


//方法执行，去警告
//去除"-(id)performSelector:(SEL)aSelector withObject:(id)object;"的警告

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define Baller_UserInfo @"Baller_UserInfo"
#define Baller_UserInfo_Authcode @"Baller_UserInfo_Authcode"
#define Baller_UserInfo_Username @"Baller_UserInfo_Username"
#define Baller_UserInfo_Devicetoken @"Baller_UserInfo_Devicetoken"
#define Baller_UserInfo_HeadImage @"Baller_UserInfo_HeadImage"
#define Baller_UserInfo_HeadImageData @"Baller_UserInfo_HeadImageData"
#define Baller_UserInfo_Height @"Baller_UserInfo_Height"
#define Baller_UserInfo_Weight @"Baller_UserInfo_Weight"
#define Baller_UserInfo_Position @"Baller_UserInfo_Position"
#define Baller_UserInfo_Sex @"Baller_UserInfo_Sex"

#define Baller_RCToken @"Baller_RCToken"


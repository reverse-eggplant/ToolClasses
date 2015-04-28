//
//  DeviceIdentifierTool.m
//  DeviceIdentifier
//
//  Created by malong on 14/11/9.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "DeviceIdentifierTool.h"

//要使用UIDevice，需要引入AppDelegate的头文件
#import "AppDelegate.h"

#import "OpenUDID.h"

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access,即使用CC_MD5要导入这个头文件


//要获取Mac地址，需要引入如下4个框架
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


//要使用广告位标示符，需要引入
#import <AdSupport/AdSupport.h>

@implementation DeviceIdentifierTool


#pragma mark getMacAddress
+ (NSString *)getMacAddress{

    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return nil;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return nil;
    }
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return nil;
        
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];

    
}


#pragma mark getUUID
+ (NSString *)getUUID{
    
    CFUUIDRef uuidRef= CFUUIDCreate( nil );   //获取uuid上下文
    
    CFStringRef uuidString = CFUUIDCreateString( nil, uuidRef ); //根据上下文创建uuid的字符串上下文
    
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));  //通过桥接，理应字符串上下文，得到一个可用arc管理的字符串
    
    
    //释放uuid上下文和字符串上下文
    CFRelease(uuidRef);
    
    CFRelease(uuidString);
    
    return result;
    
    
}


#pragma mark getOpenUdId
+ (NSString *)getOpenUdId{
    
//    unsigned char result[16];
//    
//    const char *cStr = [[[NSProcessInfo processInfo] globallyUniqueString] UTF8String];
//    CC_MD5( cStr, strlen(cStr), result );
//    
//    NSString * operUdid  = [NSString stringWithFormat:
//                 @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%08llx",
//                 result[0], result[1], result[2], result[3],
//                 result[4], result[5], result[6], result[7],
//                 result[8], result[9], result[10], result[11],
//                 result[12], result[13], result[14], result[15],
//                 arc4random() % 4294967295];
//
//    return operUdid;
    return  [OpenUDID value];
    
    
}


#pragma mark getAdvertisingIdentifier
+ (NSString *)getAdvertisingIdentifier{
    
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
}


#pragma mark getIdentifierForVendor
+ (NSString *)getIdentifierForVendor{
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    
}



@end

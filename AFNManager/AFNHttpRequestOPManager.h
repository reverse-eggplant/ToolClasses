//
//  AFNHttpRequestOPManager.h
//  LightApp
//
//  Created by malong on 14/11/20.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "Baller_NetworkInterfaces.h"
#import "Baller_HUDView.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface AFNHttpRequestOPManager : AFHTTPRequestOperationManager

@property (nonatomic,strong)MBProgressHUD * myProgressHUD;


+ (instancetype)sharedManager;

/*
 *brief 检查网络状态
 */
+ (void)checkNetWorkStatus;


/*!
 *  @brief  get请求，获取网络数据
 *
 *  @param subUrl     接口地址
 *  @param parameters 所传参数集
 *  @param block      请求返回数据的回调blcok
 */
+ (void)getWithSubUrl:(NSString *)subUrl
           parameters:(NSDictionary *)parameters  responseBlock:(void (^) (id result, NSError * error))block;

/*!
 *  @brief  post请求，获取网络数据
 *
 *  @param subUrl     接口地址
 *  @param parameters 所传参数集
 *  @param block      请求返回数据的回调blcok
 */
+ (void)postWithSubUrl:(NSString *)subUrl
            parameters:(NSDictionary *)parameters  responseBlock:(void (^) (id result, NSError * error))block;


//上传图片
+ (void)postImageWithSubUrl:(NSString *)subUrl
                 parameters:(NSDictionary *)parameters
                   fileName:(NSString *)fileName
                   fileData:(NSData *)fileData
                   fileType:(NSString *)fileType
              responseBlock:(void (^) (id result, NSError * error))block;


//获取融云会话token
+ (void)getRCTokenWithUserId:(NSString *)userId
                    userName:(NSString *)name
                portrait_uri:(NSString *)portrait_uri
               responseBlock:(void (^) (id result, NSError * error))block;


/*
 *brief 取消网络请求
 */
+ (void)cancelRequest;

@end

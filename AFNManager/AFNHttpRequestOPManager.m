//
//  AFNHttpRequestOPManager.m
//  LightApp
//
//  Created by malong on 14/11/20.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"
#import "AppDelegate.h"

#import "AFSessionManagerClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFSessionManagerClient.h"
#import "JSONKit.h"

@implementation AFNHttpRequestOPManager

/*!
 *  @brief  服务器地址,其中d=api、c=user为固定参数，m后面对应不同的参数，代表不同的接口，故前面的url可固定。通过拼接不同的接口地址来发起不同的请求
 */
#define BALLER_BASEURL @"http://123.57.35.119:84/index.php?d=api"


+ (instancetype)sharedManager{
    
    static AFNHttpRequestOPManager *_shareAFNHttpRequestOPManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shareAFNHttpRequestOPManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BALLER_BASEURL]];
        _shareAFNHttpRequestOPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil];

//        [_shareAFNHttpRequestOPManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
    });
    
    return _shareAFNHttpRequestOPManager;
}



+ (void)checkNetWorkStatus{
    
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            
            if(status == AFNetworkReachabilityStatusNotReachable){
                
                [Baller_HUDView bhud_showWithTitle:@"网络连接已断开!"];
                
            }else if(AFNetworkReachabilityStatusReachableViaWiFi == status){
                DLog(@"网络链接！");
                
            }
            return ;
        }
    }];
    
}


/*!
 *  @brief  编辑网络请求链接。现做保留，不使用该方法
 */
+ (NSString *)setURLStringWith:(NSDictionary *)parameters{
    
    NSMutableString * urlString = [[NSMutableString alloc] init];
    [urlString appendString:BALLER_BASEURL];
    if (![parameters valueForKey:@"c"]) {
        [urlString appendString:@"&c=user"];
    }
    
    return [urlString copy];
}

+ (void)getWithSubUrl:(NSString *)subUrl parameters:(NSDictionary *)parameters responseBlock:(void (^)(id, NSError *))block{
    
    [[[self class]sharedManager] showMyProgressHUDWith:@""];
    
    NSString * totalUrlString = [[NSString stringWithFormat:@"%@%@",BALLER_BASEURL,subUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"totalUrlString = %@",totalUrlString);
    NSLog(@"parameter = %@",parameters);
    
    [[[self class] sharedManager] GET:totalUrlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[[self class]sharedManager] hideMyprogressHud];
        
        if (responseObject != nil) {
            DLog(@"responseObject = %@",responseObject);

            block(responseObject,nil);
        }else{
            //将获取的数据转换成字符串
            NSString * resultString = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            //将字符串解析成json对象
            NSObject * resultObj = [resultString objectFromJSONString];
            //数据回调
            DLog(@"resultObj = %@",resultObj);

            block(resultObj,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[self class]sharedManager] hideMyprogressHud];
        DLog(@"error = %@",error);

        //failure 方法里面的operation.responseData 有可能含有我们想要的正确的数据
        block(nil,error);
    }];
    
}

+ (void)postWithSubUrl:(NSString *)subUrl parameters:(NSDictionary *)parameters responseBlock:(void (^)(id, NSError *))block{
    
    [[[self class]sharedManager] showMyProgressHUDWith:@""];

    NSString * totalUrlString = [[NSString stringWithFormat:@"%@%@",BALLER_BASEURL,subUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"totalUrlString = %@",totalUrlString);
    NSLog(@"parameter = %@",parameters);
    
    [[[self class] sharedManager] POST:totalUrlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[[self class]sharedManager] hideMyprogressHud];


        
        if (responseObject != nil) {
            block(responseObject,nil);
            DLog(@"responseObject = %@",responseObject);
        }else{
            //将获取的数据转换成字符串
            NSString * resultString = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            //将字符串解析成json对象
            NSObject * resultObj = [resultString objectFromJSONString];
            //数据回调
            DLog(@"resultObj = %@",resultObj);

            block(resultObj,nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[self class]sharedManager] hideMyprogressHud];
        DLog(@"error = %@",error);

        //failure 方法里面的operation.responseData 有可能含有我们想要的正确的数据
        block(nil,error);
    }];
}

//上传图片
+ (void)postImageWithSubUrl:(NSString *)subUrl
                 parameters:(NSDictionary *)parameters
                   fileName:(NSString *)fileName
                   fileData:(NSData *)fileData
                   fileType:(NSString *)fileType
              responseBlock:(void (^) (id result, NSError * error))block{
    
    [[[self class]sharedManager] showMyProgressHUDWith:@""];

    NSString * totalUrlString = [[NSString stringWithFormat:@"%@%@",BALLER_BASEURL,subUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"totalUrlString = %@",totalUrlString);
    NSLog(@"parameter = %@",parameters);
    
    [[[self class] sharedManager] POST:totalUrlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (fileData) {
            //添加图片
            [formData appendPartWithFileData:fileData
                                        name:fileName?:@"pic"
                                    fileName:fileName?:@"headPhoto.jpg"
                                    mimeType:fileType?:@"image/jpg"];

        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[[self class]sharedManager] hideMyprogressHud];

        if (responseObject != nil) {
            block(responseObject,nil);
            DLog(@"responseObject = %@",responseObject);
        }else{
            //将获取的数据转换成字符串
            NSString * resultString = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            //将字符串解析成json对象
            NSObject * resultObj = [resultString objectFromJSONString];
            //数据回调
            DLog(@"resultObj = %@",resultObj);
            
            block(resultObj,nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[self class]sharedManager] hideMyprogressHud];
        DLog(@"error = %@",error);
        block(nil,error);
        
    }];
    
}


//获取融云会话token
+ (void)getRCTokenWithUserId:(NSString *)userId
                    userName:(NSString *)name
                portrait_uri:(NSString *)portrait_uri
               responseBlock:(void (^) (id result, NSError * error))block
{
    
    [[[self class] sharedManager] GET:@"http://www.alayy.com/index.php?d=api&c=chat_b&m=get_token" parameters:@{@"user_id":userId,@"name":name,@"portrait_uri":portrait_uri} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            DLog(@"responseObject = %@",responseObject);
            block(responseObject,nil);
        }else{
            //将获取的数据转换成字符串
            NSString * resultString = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            //将字符串解析成json对象
            NSObject * resultObj = [resultString objectFromJSONString];
            //数据回调
            DLog(@"resultObj = %@",resultObj);
            
            block(resultObj,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"error = %@",error);
        block(nil,error);
    }];

}

#pragma mark 取消网络请求

+ (void)cancelRequest{
    
    NSLog(@"cancelRequest");
    [[[[self class] sharedManager] operationQueue] cancelAllOperations];
    
}

#pragma mark 网络加载等待条
- (void)showMyProgressHUDWith:(NSString *)text
{
    if (![[MLViewConrollerManager sharedVCMInstance] rootViewController]) {
        return;
    }
    if (!_myProgressHUD) {
        _myProgressHUD = [[MBProgressHUD alloc] initWithView:[[MLViewConrollerManager sharedVCMInstance] rootViewController].view];
        _myProgressHUD.mode = MBProgressHUDModeIndeterminate;
        _myProgressHUD.animationType = MBProgressHUDAnimationZoom;
    }
    
    if (text) {
        _myProgressHUD.labelText = text;
        
    }else{
        _myProgressHUD.labelText = @"稍等\nO(∩_∩)O";
        
    }
    [[[MLViewConrollerManager sharedVCMInstance] rootViewController].view addSubview:_myProgressHUD];
    [[[MLViewConrollerManager sharedVCMInstance] rootViewController].view bringSubviewToFront:_myProgressHUD];
    
    [_myProgressHUD show:YES];
    
}

- (void)hideMyprogressHud{
    if (!_myProgressHUD || ![[MLViewConrollerManager sharedVCMInstance] rootViewController]) {
        return;
    }
    [_myProgressHUD setHidden:YES];
    [_myProgressHUD removeFromSuperview];
    _myProgressHUD = nil;
    
}

@end

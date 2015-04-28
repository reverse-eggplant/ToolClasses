//
//  LShareSheetView.h
//  FBAuto
//
//  Created by lichaowei on 14-7-24.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UMSocial.h"

#import <TencentOpenAPI/QQApi.h>

#import "WXApi.h"

/**
 *  分享 sheetView
 */

//items = @[@"朋友圈",@"微博",@"QQ空间",@"微信",@"QQ",];

typedef enum {
    
    Share_WX_PengYouQuan = 100,
    Share_WX_HaoYou = 103,
    Share_WeiBo = 101,
    Share_QQZone = 102,
    Share_QQ = 104
    
}Share_Type;

typedef enum {
    
    Share_Success = 1,//分享成功
    Share_Fail = 2 //分享失败
    
}Share_Result;

typedef void(^ ActionBlock) (NSInteger buttonIndex,Share_Type shareType);
typedef void(^ ShareResultBlock) (Share_Result result,Share_Type type);//分享结果block

@interface LShareSheetView : UIView<UMSocialUIDelegate>

{
    ActionBlock actionBlock;
    
    ShareResultBlock shareBlock;
    
    UIView *bgView;
    NSArray *items;
   
    NSString *_shareTitle;//标题
    //分享内容
    NSString *_shareContent;
    NSString *_shareUrl;
    UIImage *_shareImage;
    
    UIViewController *_targetViewController;
}

+ (id)shareInstance;

- (void)actionBlock:(ActionBlock)aBlock;

- (void)shareResult:(ShareResultBlock)aBlock;//分享结果的block

- (void)showShareContent:(NSString *)content
                   title:(NSString *)title
                shareUrl:(NSString *)url
              shareImage:(UIImage *)aImage
    targetViewController:(UIViewController *)targetViewController;

@end

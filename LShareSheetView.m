//
//  LShareSheetView.m
//  FBAuto
//
//  Created by lichaowei on 14-7-24.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "LShareSheetView.h"
#import "AppDelegate.h"

#define KLEFT 20
#define KTOP 20
#define DIS_SMALL 10
#define DIS_BIG 22

#define VIEW_HEIGHT 236

@interface CustomButton : UIButton

@property(nonatomic,assign)Share_Type shareType;

@property(nonatomic,retain)NSString *umShareType;//友盟分享类型

@end

@implementation CustomButton

@end


@implementation LShareSheetView
+ (id)shareInstance
{
    static dispatch_once_t once_t;
    static LShareSheetView *dataBlock;
    
    dispatch_once(&once_t, ^{
        dataBlock = [[LShareSheetView alloc]init];
    });
    
    return dataBlock;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.window.windowLevel = UIAlertViewStyleDefault;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        self.alpha = 0.0;
        
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].keyWindow.bottom, ScreenWidth, VIEW_HEIGHT)];
        bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        [self addSubview:bgView];
        
        items = @[@"朋友圈",@"微博",@"QQ空间",@"微信",@"QQ"];
        NSArray *images = @[@"pengyouquan72_7222x",@"weibo90_72",@"qqzone",@"weixin72_72",@"QQ72_72"];
        
        NSArray *shareType = @[UMShareToWechatTimeline,UMShareToSina,UMShareToQzone,UMShareToWechatSession,UMShareToQQ];
        
        CGFloat aWidth = 36.0;
        CGFloat left = (ScreenWidth - 36 * 3) / 4;
        CGFloat aHeight = 36.f;
        CGFloat top = 55 / 2.f;
        
        int line = 0;
        for (int i = 0; i < items.count; i ++) {
            
            line = i / 3;
            
            CustomButton *itemBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
//            itemBtn.backgroundColor = [UIColor orangeColor];
            [itemBtn setFrame:CGRectMake(left + (left + aWidth) * (i % 3), top + (20 + aWidth + 10) * line, aWidth, aHeight)];
            [itemBtn setBackgroundImage:[UIImage imageNamed:[images objectAtIndex:i]] forState:UIControlStateNormal];
            [bgView addSubview:itemBtn];
            itemBtn.tag = 100 + i;
            itemBtn.shareType = 100 + i;
            itemBtn.umShareType = shareType[i];
            
            [itemBtn addTarget:self action:@selector(actionToDo:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemBtn.left - aWidth / 2.0, itemBtn.bottom + 5, aWidth * 2, 20)];
            titleLabel.text = [items objectAtIndex:i];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:titleLabel];
        }
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(KLEFT, 350/2.0, ScreenWidth - KLEFT * 2, 45);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [cancelButton setBackgroundImage:[UIImage imageNamed:@"quxiao_button600_90"] forState:UIControlStateNormal];
        [bgView addSubview:cancelButton];
        
        [cancelButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        
//        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
//        [self show];
    }
    return self;
}

- (void)showShareContent:(NSString *)content
                   title:(NSString *)title
                shareUrl:(NSString *)url
              shareImage:(UIImage *)aImage
    targetViewController:(UIViewController *)targetViewController
{
    _shareTitle = title;
    _shareContent = content;
    _shareUrl = url;
    _shareImage = aImage;
    
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *rootVc = delegate.window.rootViewController;
    
    _targetViewController = targetViewController == nil ? rootVc : targetViewController;
    
    UIView *root = [UIApplication sharedApplication].keyWindow;
    [root addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect aFrame = bgView.frame;
        aFrame.origin.y = [UIApplication sharedApplication].keyWindow.bottom - VIEW_HEIGHT;
        bgView.frame = aFrame;
        
        self.alpha = 1.0;
    }];
}

#pragma mark 分享操作

- (void)actionBlock:(ActionBlock)aBlock
{
    actionBlock = aBlock;
}

#pragma mark 分享结果block

- (void)shareResult:(ShareResultBlock)aBlock
{
    shareBlock = aBlock;
}

/**
 *  分享结果
 *
 *  @param result 成功与失败
 *  @param aType  分享平台
 */
- (void)shareResult:(Share_Result)result shareType:(Share_Type)aType
{
    if (shareBlock) {
        shareBlock(result,aType);
    }
}

- (void)actionToDo:(CustomButton *)button
{
    //0,1,2
    
    [self autoShareTo:button.umShareType];//分享
    
    if (button.tag - 100 < items.count) {
        
        if (actionBlock) {
            actionBlock(button.tag,button.shareType);
        }
        
    }
    
    [self hidden];
}

- (void)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect aFrame = bgView.frame;
        aFrame.origin.y = [UIApplication sharedApplication].keyWindow.bottom;
        bgView.frame = aFrame;
        
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    NSLog(@"touch view %@",touch.view);
    
    if ([touch.view isKindOfClass:[LShareSheetView class]]) {
        [self hidden];
        
    }
}


#pragma mark - 分享处理

- (void)autoShareTo:(NSString *)type
{
    if ([type isEqualToString:UMShareToQQ] || [type isEqualToString:UMShareToQzone]) {
        
        if (![QQApi isQQInstalled] || ![QQApi isQQSupportApi]) {
            
            [LTools alertText:@"抱歉,没有安装QQ客户端"];
            
            return;
        }
    }
    
    if ([type isEqualToString:UMShareToWechatSession] || [type isEqualToString:UMShareToWechatTimeline]) {
        
        if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
            
            [LTools alertText:@"您的设备没有安装微信客户端"];
            
            return;
        }
    }
    
    NSString *title = _shareTitle;
    
    NSString *content = _shareContent;
    
    NSString *url = _shareUrl;
    
    UIImage *shareImage = _shareImage;
    
    UIViewController *root = _targetViewController;
    
    if ([type isEqualToString:UMShareToQQ]) {
        
        [UMSocialData defaultData].extConfig.qqData.title = title;
        [UMSocialData defaultData].extConfig.qqData.url = url; //设置你自己的url地址;
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[type] content:content image:shareImage location:nil urlResource:nil presentedController:root completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                
                NSLog(@"QQ分享成功");
                
                [self shareResult:Share_Success shareType:Share_QQ];
                
            }else{
                
                NSLog(@"分享失败");
                [self shareResult:Share_Fail shareType:Share_QQ];
            }
        }];
        
        
    }else if ([type isEqualToString:UMShareToSina]){
        
        [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"%@%@",content,url] shareImage:shareImage socialUIDelegate:self];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(root,[UMSocialControllerService defaultControllerService],YES);
        
    }else if ([type isEqualToString:UMShareToQzone]){
        
        //qqzone
        [UMSocialData defaultData].extConfig.qzoneData.title = title;
        [UMSocialData defaultData].extConfig.qzoneData.url = url; //设置你自己的url地址;
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[type] content:content image:shareImage location:nil urlResource:nil presentedController:root completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                
                NSLog(@"QQ空间分享成功");
                
                [self shareResult:Share_Success shareType:Share_QQZone];
                
            }else{
                
                NSLog(@"QQ空间分享失败");
                [self shareResult:Share_Fail shareType:Share_QQZone];
            }
        }];
        
        
    }else if ([type isEqualToString:UMShareToWechatSession]){
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url; //设置你自己的url地址;
        
        [[UMSocialControllerService defaultControllerService] setShareText:content shareImage:shareImage socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        snsPlatform.snsClickHandler(root,[UMSocialControllerService defaultControllerService],YES);
        
    }else if ([type isEqualToString:UMShareToWechatTimeline]){ //朋友圈
        
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url; //设置你自己的url地址;
        
        [[UMSocialControllerService defaultControllerService] setShareText:content shareImage:shareImage socialUIDelegate:self];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(root,[UMSocialControllerService defaultControllerService],YES);
    }
}

#pragma mark - 分享 delegate


//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@ 成功",[[response.data allKeys] objectAtIndex:0]);
        
        [self shareResult:Share_Success shareType:Share_QQZone];
        
    }else
    {
        NSLog(@"share to sns name is %@ 失败",[[response.data allKeys] objectAtIndex:0]);
        
        [self shareResult:Share_Fail shareType:Share_QQZone];
    }
}

@end


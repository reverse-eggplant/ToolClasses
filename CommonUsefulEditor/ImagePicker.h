//
//  Baller_ImagePicker.h
//  Baller
//
//  Created by malong on 15/1/17.
//  Copyright (c) 2015年 malong. All rights reserved.
//

typedef void (^Baller_ImagePicker_ImageChosenBlock)(UIImage * image); //选中图片后的回调

#import <Foundation/Foundation.h>

@interface Baller_ImagePicker : NSObject
{
    NSString * _alertTitle;
    NSString * _message;
    NSArray * _actionTitles;
}
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) UIAlertController * alertController;
@property (nonatomic, copy)Baller_ImagePicker_ImageChosenBlock baller_ImagePicker_ImageChosenBlock;
/*!
 *  @brief  弹出框初始化
 *
 *  @param alertTitle   弹出框标题
 *  @param message      弹出框信息
 *  @param actionTitles 弹出框标题数组
 */
- (id)initWithTitile:(NSString *)alertTitle
             message:(NSString *)message;

- (void)showImageChoseAlertView;

@end

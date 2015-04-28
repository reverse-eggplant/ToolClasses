//
//  ImageFactory.h
//  LightApp
//
//  Created by malong on 14/12/1.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageFactory : NSObject

/*
 *brief:ios根据视频地址获取某一帧的图像
 *param videoURL 视频录制完后的本地存储地址
 *param time 视频截取时间点
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL
                             atTime:(NSTimeInterval)time;



#pragma mark 屏幕截图并保存到相册
+ (UIImage*)saveImageFromView:(UIView*)view;

+ (void)savePhotosAlbum:(UIImage *)image;

+ (void)saveImageFromToPhotosAlbum:(UIView*)view;

+ (void)imageSavedToPhotosAlbum:(UIImage *)image
       didFinishSavingWithError:(NSError *)error
                    contextInfo:(void *) contextInfo;

@end

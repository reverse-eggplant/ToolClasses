//
//  Baller_ImagePicker.m
//  Baller
//
//  Created by malong on 15/1/17.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#import "Baller_ImagePicker.h"
#import <AVFoundation/AVFoundation.h>

@interface Baller_ImagePicker()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@end

@implementation Baller_ImagePicker

- (id)init{
    self = [super init];
    if (!self) {
        return  nil;
    }
    return self;
}

- (id)initWithTitile:(NSString *)alertTitle
               message:(NSString *)message
{    self = [self init];
    if (self) {
        _alertTitle = alertTitle;
        _message = message;
    }
    return self;
}

- (UIAlertController *)alertController
{
    if (!_alertController) {
        _alertController = [UIAlertController new];
        
    }
    return _alertController;
}


/*!
 *  @brief  弹出照片选择提示框
 */
- (void)showImageChoseAlertView{
    
#ifdef __IPHONE_8_0
     self.alertController = [UIAlertController alertControllerWithTitle:_alertTitle?:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (_actionTitles.count) {
        
    }else{
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"摄像机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
            
        }]];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"本地相簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            
        }]];
        
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
    }

    
    [[[MLViewConrollerManager sharedVCMInstance] rootViewController] presentViewController:self.alertController animated:YES completion:nil];
    
    
#else
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"选择图片"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"摄像机",@"本地相簿",nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
#endif
}

/*!
 *  @brief  检查相册或相机是否允许访问
*/
- (BOOL)checkImagePicker{
    if (IOS7) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus ==AVAuthorizationStatusRestricted){
            DLog(@"Restricted");
        }else if(authStatus == AVAuthorizationStatusDenied){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请在设备的<设置-隐私-相机>中允许此程序访问相机。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
            DLog(@"Authorized");
            return YES;

        }else if(authStatus == AVAuthorizationStatusNotDetermined){
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if(granted){
                    DLog(@"Granted access to %@", mediaType);
                }
                else {
                    DLog(@"Not granted access to %@", mediaType);
                }
            }];
        }else {
            DLog(@"Unknown authorization status");
        }
    }
    return YES;
}

#pragma --mark UIActionSheetDelegate method

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (![self checkImagePicker]) {
        return;
    }
    switch (buttonIndex) {
        case 0:
            [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

            break;
        default:
            break;
    }
    
}

#pragma --mark choose method

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
 
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = sourceType;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [[[MLViewConrollerManager sharedVCMInstance] rootViewController] presentViewController:imagePicker animated:YES completion:^{}];
    
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.00001);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *imageNew = [info objectForKey:UIImagePickerControllerEditedImage];

    //对图片大小进行压缩--
    self.image = imageNew;
    __BLOCKOBJ(blockSelf, self)
    if (self.baller_ImagePicker_ImageChosenBlock) {
        
        self.baller_ImagePicker_ImageChosenBlock(blockSelf.image);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[[MLViewConrollerManager sharedVCMInstance] rootViewController] dismissViewControllerAnimated:YES completion:^{}];
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end

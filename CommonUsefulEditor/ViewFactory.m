//
//  ViewFactory.m
//  LightApp
//
//  Created by malong on 14/11/26.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "ViewFactory.h"

@implementation ViewFactory

+ (UIView *)clearViewWithFrame:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (UIBarButtonItem *)getABarButtonItemWithImage:(NSString *)imageName
                                imageEdgeInsets:(UIEdgeInsets)edgeInsets
                                         target:(id)target
                                      selection:(SEL)selectAction
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0.0, 0.0, 44.0, 44.0);
    if (imageName) {
        [button setImage:IMAGE_PNG(imageName) forState:UIControlStateNormal];
    }
    if (target && selectAction) {
        [button addTarget:target action:selectAction forControlEvents:UIControlEventTouchUpInside];
 
    }
    button.imageEdgeInsets = edgeInsets;
    
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
    
}

+ (UIBarButtonItem *)getABarButtonItemWithTitle:(NSString *)title
                                titleEdgeInsets:(UIEdgeInsets)edgeInsets
                                         target:(id)target
                                      selection:(SEL)selectAction{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSTEM_FONT_S(15.0);

    button.frame = CGRectMake(0.0, 0.0, [NSStringManager sizeOfCurrentString:title font:15.0 contentSize:CGSizeMake(ScreenWidth/2.0, NavigationBarHeight)].width+10.0, 44.0);
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];

    }
    if (target && selectAction) {
        [button addTarget:target action:selectAction forControlEvents:UIControlEventTouchUpInside];
        
    }
    button.titleEdgeInsets = edgeInsets;
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
    
}


+ (UILabel *)addAlabelForAView:(UIView *)aView
                      withText:(NSString *)labelText
                         frame:(CGRect)labelFrame
                          font:(UIFont *)labelFont
                     textColor:(UIColor *)labelColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = labelText;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.backgroundColor = [UIColor clearColor];
    label.font = labelFont;
    if (labelColor) {
        label.textColor = labelColor;
        
    }
    if (aView) {
        [aView addSubview:label];
    }
    return label;
}


+ (UIButton *)getAButtonWithFrame:(CGRect)frame
                       nomalTitle:(NSString *)nomalTitle
                          hlTitle:(NSString *)hlTitle
                       titleColor:(UIColor *)tColor
                          bgColor:(UIColor *)bgColor
                           nImage:(NSString *)nImage
                           hImage:(NSString *)hImage
                           action:(SEL)selector
                           target:(id)target
                       buttonTpye:(UIButtonType)theButtodnTpye
{
    UIButton *button = nil;
    if (theButtodnTpye) {
        button = [UIButton buttonWithType:theButtodnTpye];
        
    }else{
        button = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    button.frame = frame;
    if (nomalTitle) {[button setTitle:nomalTitle forState:UIControlStateNormal];}
    if (hlTitle) {[button setTitle:hlTitle forState:UIControlStateHighlighted];}
    if (tColor) {
        [button setTitleColor:tColor forState:UIControlStateNormal];
    }
    
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    
    if (nImage) {[button setImage:[UIImage imageNamed:nImage] forState:UIControlStateNormal];}
    if (hImage) {[button setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];}
    if (target && selector) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}


+ (UITextField *)getATFWithFrame:(CGRect)frame
                        delegate:(id)delegate
                     palceHolder:(NSString *)placeHolder
               leftViewImageName:(NSString *)imageName
{
    UITextField * textfeild = [[UITextField alloc]initWithFrame:frame];
    textfeild.delegate = delegate;
    [textfeild setBorderStyle:UITextBorderStyleNone];
    
    textfeild.autocorrectionType = UITextAutocorrectionTypeNo;
    textfeild.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textfeild.returnKeyType = UIReturnKeyDone;
    textfeild.placeholder =placeHolder;
    textfeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (imageName) {
        textfeild.leftViewMode = UITextFieldViewModeAlways;
        textfeild.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        
    }
    return textfeild;
}

+ (UIView *)addLineToView:(UIView *)view frame:(CGRect)frame color:(UIColor *)lineColor
{
    UIView *line = [[UIView alloc]initWithFrame:frame];
    if (lineColor) {
        line.backgroundColor = lineColor;
        
    }else{
        line.backgroundColor =  UIColorFromRGB(0Xffffff);
        
    }
    [view addSubview:line];
    return line;
}

+ (CALayer *)addLayerToView:(CALayer *)layer
                      frame:(CGRect)frame
                 layerColor:(UIColor *)layerColor
{
    CALayer * subLayer = [CALayer layer];
    subLayer.frame = frame;
    if (layerColor) {
        subLayer.backgroundColor = layerColor.CGColor;
        
    }else{
        subLayer.backgroundColor =  UIColorFromRGB(0Xffffff).CGColor;
        
    }
    [layer addSublayer:subLayer];
    return subLayer;
}


@end

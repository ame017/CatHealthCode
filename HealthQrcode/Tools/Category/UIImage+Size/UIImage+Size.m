//
//  UIImage+Size.m
//  TJSWorking
//
//  Created by ame on 2017/10/17.
//  Copyright © 2017年 tejisong. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

- (UIImage*)scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

@end

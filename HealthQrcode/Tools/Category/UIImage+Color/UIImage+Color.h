//
//  UIImage+Color.h
//  koudaizikao
//
//  Created by lsq on 15/12/1.
//  Copyright © 2015年 withustudy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  此点区域的色值
 *
 *  @param point CGPoint
 *
 *  @return 色值
 */
- (UIColor *)colorAtPoint:(CGPoint)point;

/**
 修改颜色

 @param color 颜色
 @return 图片
 */
- (UIImage *)changeToColor:(UIColor *)color;

@end

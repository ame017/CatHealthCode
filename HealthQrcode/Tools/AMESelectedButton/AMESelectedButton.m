//
//  AMESelectedButton.m
//  HKBTC
//
//  Created by AME on 2019/8/26.
//  Copyright © 2019 ame017. All rights reserved.
//

#import "AMESelectedButton.h"


@implementation AMESelectedButton

- (void)setNormal_backgroundColor:(UIColor *)normal_backgroundColor{
    _normal_backgroundColor = normal_backgroundColor;
    [self setBackgroundImage:[self imageWithColor:normal_backgroundColor] forState:UIControlStateNormal];
}
- (void)setHighlighted_backgroundColor:(UIColor *)highlighted_backgroundColor{
    _highlighted_backgroundColor = highlighted_backgroundColor;
    [self setBackgroundImage:[self imageWithColor:highlighted_backgroundColor] forState:UIControlStateHighlighted];
}
- (void)setSelected_backgroundColor:(UIColor *)selected_backgroundColor{
    _selected_backgroundColor = selected_backgroundColor;
    [self setBackgroundImage:[self imageWithColor:selected_backgroundColor] forState:UIControlStateSelected];
}
- (void)setDisable_backgroundColor:(UIColor *)disable_backgroundColor{
    _disable_backgroundColor = disable_backgroundColor;
    [self setBackgroundImage:[self imageWithColor:disable_backgroundColor] forState:UIControlStateDisabled];
}


// 设置颜色
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

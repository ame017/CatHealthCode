//
//  UIAlertController+Maker.h
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Maker)



/**
 生成一个只有确定按钮的alert

 @param message 提示信息
 @param okEvent 确定按钮点击事件
 @param isShow 是否直接显示
 @return 返回这个alert
 */
+ (instancetype)ame_okAlertWithMessage:(NSString *)message okEvent:(void(^)(void))okEvent isShow:(BOOL)isShow;



/**
 生成一个只有确定按钮的alert
 
 @param message 提示信息
 @param okEvent 确定按钮点击事件
 @param cancelEvent 取消按钮点击事件
 @param isShow 是否直接显示
 @return 返回这个alert
 */
+ (instancetype)ame_cancelAlertWithMessage:(NSString *)message okEvent:(void(^)(void))okEvent cancelEvent:(void(^)(void))cancelEvent isShow:(BOOL)isShow;


/**
 生成一个带取消的sheet

 @param title 标题
 @param message 提示信息
 @param cancelEvent 取消点击事件
 @return 返回这个sheet
 */
+ (instancetype)ame_sheetWithTitle:(NSString *)title message:(NSString *)message cancelEvent:(void(^)(void))cancelEvent;


/**
 显示
 */
- (void)show;
@end

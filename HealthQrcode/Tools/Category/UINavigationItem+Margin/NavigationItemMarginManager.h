//
//  NavigationItemMarginManager.h
//  WYEAPClient
//
//  Created by pc37 on 17/7/25.
//  Copyright © 2017年 pc47. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 AME:该类设置为单例 用于管理Margin是否生效
 */
@interface NavigationItemMarginManager : NSObject


/**
 左边距是否生效
 */
@property (nonatomic, assign) BOOL leftMarginEnable;

/**
 右边距是否生效
 */
@property (nonatomic, assign) BOOL rightMarginEnable;

/**
 左边距
 */
@property (nonatomic, assign) NSInteger leftMargin;

/**
 右边距
 */
@property (nonatomic, assign) NSInteger rightMargin;


/**
 单例方法 返回全局Manager

 @return 返回manager
 */
+(instancetype)sharedManager;

@end

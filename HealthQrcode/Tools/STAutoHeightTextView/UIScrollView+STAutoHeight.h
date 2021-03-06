//
//  UIScrollView+STAutoHeight.h
//  AUtoLayoutTest
//
//  Created by StriVever on 2017/12/26.
//  Copyright © 2017年 StriVever. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const st_layout_frame = @"st_layout_frame";
static NSString * const st_auto_layout = @"st_auto_layout";

@interface UIScrollView (STAutoHeight)

/**
 是否自适应高度
 */
@property (nonatomic, assign)IBInspectable BOOL isAutoHeightEnable;

/**
 设置最大高度
 */
@property (nonatomic, assign)IBInspectable CGFloat st_maxHeight;

/**
 最小高度
 */
@property (nonatomic, assign)IBInspectable CGFloat st_minHeight;


@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@property (nonatomic, copy) NSString *layout_key;

@end

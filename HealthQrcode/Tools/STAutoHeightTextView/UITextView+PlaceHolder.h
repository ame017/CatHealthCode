//
//  UITextView+PlaceHolder.h
//  AUtoLayoutTest
//
//  Created by StriVever on 2017/12/26.
//  Copyright © 2017年 StriVever. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UITextView (PlaceHolder)


/**
 占位符
 */
@property (nonatomic, copy)IBInspectable NSString * st_placeHolder;
/**
 占位符颜色
 */
@property (nonatomic, strong) IBInspectable UIColor * st_placeHolderColor;

/**
 占位Label
 */
@property (nonatomic, strong) UITextView * st_placeHolderLabel;

/**
 行间距
 */
@property (nonatomic, assign)IBInspectable CGFloat st_lineSpacing;
@property (nonatomic, copy) void(^textViewHeightDidChangedHandle)(CGFloat textViewHeight);
@end

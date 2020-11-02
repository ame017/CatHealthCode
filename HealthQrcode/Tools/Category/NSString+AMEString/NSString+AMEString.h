//
//  NSString+AMEString.h
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AMEString)

/**
 *  按照前缀和后缀提取字符串,多用于提取html中的图片
 *
 *  @param fromString 前字符串,注意转义字符
 *  @param toString   后字符串,注意转义字符
 *
 *  @return 返回一个数组
 */
- (NSArray *)ame_componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;
/**
 *  转成UTF8
 *
 *  @return 返回一个string
 */
- (NSString *)ame_stringToUTF8;
/**
 *  字符串直接运算(要求字符串是纯数字) 支持精确位数(-1精确到有数字的位数)
 *
 *  @param calculate 一步运算 加减乘除
 *  @param breviary 小数点精确位数 输入-1精确到有数字的位数
 *
 *  @return 返回新的数字字符串
 */
- (NSString *)ame_stringCalculate:(NSString *)calculate breviary:(NSInteger)breviary;

/**
 是否包含某字符串

 @param subString 要查询的字符串
 @return 返回结果bool
 */
- (BOOL)ame_hasSubString:(NSString *)subString;

/**
 是否是整形

 @return 是否是整形
 */
- (BOOL)ame_isPureInt;

/**
 是否是浮点
 
 @return 浮点
 */
- (BOOL)ame_isPureFloat;

/**
 正则比较

 @param regex 正则表达式
 @return 是否符合
 */
- (BOOL)ame_compareWithRegex:(NSString *)regex;


/**
 字母数字占一半的length

 @return length
 */
- (NSInteger)ame_lengthConsiderLetter;

/**
 输出大写金额

 @return 字符串
 */
- (NSString *)ame_toCapitalLetters;

/**
 去除html标签

 @return 字符串
 */
- (NSString *)ame_filterHTML;
@end

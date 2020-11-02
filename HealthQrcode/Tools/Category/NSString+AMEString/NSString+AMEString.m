//
//  NSString+AMEString.m
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "NSString+AMEString.h"

@implementation NSString (AMEString)
- (NSArray *)ame_componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString{
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    return subStringsArray;
}
- (NSString *)ame_stringToUTF8{
    NSCharacterSet * set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString * UTF8 = [self stringByAddingPercentEncodingWithAllowedCharacters:set];
    return UTF8;
}

- (NSString *)ame_stringCalculate:(NSString *)calculate breviary:(NSInteger)breviary{
    //获取数据并进行计算
    double stringNum;
    if ([self isEqualToString:@""]) {
        stringNum = 0;
    }else{
        stringNum = [self doubleValue];
    }
    NSString * calculateNumString = [calculate substringFromIndex:1];
    double calculateNum = [calculateNumString doubleValue];
    char operator = [calculate characterAtIndex:0];
    double answer = stringNum;
    switch (operator) {
        case '+':{
            answer = stringNum + calculateNum;
        }break;
        case '-':{
            answer = stringNum - calculateNum;
        }break;
        case '*':{
            answer = stringNum * calculateNum;
        }break;
        case '/':{
            answer = stringNum / calculateNum;
        }break;
        default:{
            NSLog(@"operatorWrong");
        }break;
    }
    //根据用户输入的精确位数进行修改
    NSString * newAnswerString;
    if (breviary==-1) {
        if ((long)answer == answer) {
            //证明answer不是个小数
            newAnswerString = [NSString stringWithFormat:@"%ld",(long)answer];
        }else{
            //如果是个小数,砍掉0输出
            NSString * answerString = [NSString stringWithFormat:@"%lf",answer];
            NSRange zeroRange;
            BOOL hasRange = NO;
            BOOL needCut = NO;
            for (int i=0; i<answerString.length; i++) {
                if ([answerString characterAtIndex:i]=='0') {
                    if (!hasRange) {
                        hasRange = YES;
                        zeroRange = NSMakeRange(i, 1);
                    }else{
                        zeroRange = NSMakeRange(zeroRange.location, zeroRange.length+1);
                    }
                    //最后一位
                    if (i == answerString.length-1 & zeroRange.location+zeroRange.length == answerString.length) {
                        needCut = YES;
                    }
                }else{
                    hasRange = NO;
                }
            }
            if (needCut) {
                newAnswerString = [answerString substringToIndex:zeroRange.location];
            }
        }
    }else if (breviary >= 0){
        NSString * answerString = [NSString stringWithFormat:@"%lf",answer];
        NSArray * answerArray = [answerString componentsSeparatedByString:@"."];
        NSString * decimals = answerArray.lastObject;
        if (decimals.length == breviary) {
            newAnswerString = answerString;
        }else if (decimals.length < breviary){
            for (int i=0; i<breviary-decimals.length; i++) {
                answerString = [NSString stringWithFormat:@"%@%@",answerString,@"0"];
            }
            newAnswerString = answerString;
        }else if (decimals.length > breviary){
            NSString * newDecimals = [decimals substringToIndex:breviary];
            newAnswerString = [NSString stringWithFormat:@"%@.%@",answerArray.firstObject,newDecimals];
        }
    }else{
        NSLog(@"breviaryWrong");
        newAnswerString = [NSString stringWithFormat:@"%lf",answer];
    }
    return newAnswerString;
}

- (BOOL)ame_hasSubString:(NSString *)subString{
    BOOL result = NO;
    if ([self rangeOfString:subString].location != NSNotFound) {
        result = YES;
    }
    return result;
}

- (BOOL)ame_isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (BOOL)ame_isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)ame_compareWithRegex:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch){
        return NO;
    }
    return YES;
}
- (NSInteger)ame_lengthConsiderLetter{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)ame_toCapitalLetters{
    //首先转化成标准格式        “200.23”
    NSMutableString *tempStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[self doubleValue]]];
    //位
    NSArray *carryArr1=@[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *carryArr2=@[@"分",@"角"];
    //数字
    NSArray *numArr=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    
    NSArray *temarr = [tempStr componentsSeparatedByString:@"."];
    //小数点前的数值字符串
    NSString *firstStr=[NSString stringWithFormat:@"%@",temarr[0]];
    //小数点后的数值字符串
    NSString *secondStr=[NSString stringWithFormat:@"%@",temarr[1]];
    
    //是否拼接了“零”，做标记
    bool zero=NO;
    //拼接数据的可变字符串
    NSMutableString *endStr=[[NSMutableString alloc] init];
    
    /**
     *  首先遍历firstStr，从最高位往个位遍历    高位----->个位
     */
    
    for(int i = (int)firstStr.length; i > 0 ; i--){
        //取最高位数
        NSInteger MyData=[[firstStr substringWithRange:NSMakeRange(firstStr.length-i, 1)] integerValue];
        
        if ([numArr[MyData] isEqualToString:@"零"]) {
            
            if ([carryArr1[i-1] isEqualToString:@"万"]||[carryArr1[i-1] isEqualToString:@"亿"]||[carryArr1[i-1] isEqualToString:@"元"]||[carryArr1[i-1] isEqualToString:@"兆"]) {
                //去除有“零万”
                if (zero) {
                    endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:(endStr.length-1)]];
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }else{
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }
                
                //去除有“亿万”、"兆万"的情况
                if ([carryArr1[i-1] isEqualToString:@"万"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"亿"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                }
                //去除“兆亿”
                if ([carryArr1[i-1] isEqualToString:@"亿"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }
                
                
            }else{
                if (!zero) {
                    [endStr appendString:numArr[MyData]];
                    zero=YES;
                }
                
            }
            
        }else{
            //拼接数字
            [endStr appendString:numArr[MyData]];
            //拼接位
            [endStr appendString:carryArr1[i-1]];
            //不为“零”
            zero=NO;
        }
    }
    
    /**
     *  再遍历secondStr    角位----->分位
     */
    
    if ([secondStr isEqualToString:@"00"]) {
        [endStr appendString:@"整"];
    }else{
        for(int i=(int)secondStr.length;i>0;i--)
        {
            //取最高位数
            NSInteger MyData=[[secondStr substringWithRange:NSMakeRange(secondStr.length-i, 1)] integerValue];
            
            [endStr appendString:numArr[MyData]];
            [endStr appendString:carryArr2[i-1]];
        }
    }
    
    return endStr;
}

- (NSString *)ame_filterHTML{
    NSString * answer = @"";
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    answer = [regularExpretion stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return answer;
}
@end

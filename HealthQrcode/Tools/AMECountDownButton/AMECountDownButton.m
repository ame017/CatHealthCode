//
//  AMECountDownButton.m
//  ZBEX
//
//  Created by AME on 2018/12/18.
//  Copyright © 2018 ame017. All rights reserved.
//

#import "AMECountDownButton.h"
@interface AMECountDownButton ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger nowTime;

@property (nonatomic, strong) UIColor * originalBackgroundColor;
@property (nonatomic, strong) UIColor * originalBorderColor;

@end
IB_DESIGNABLE
@implementation AMECountDownButton

- (void)dealloc{
    [self.timer invalidate];
}

- (void)countDownStart{
    if (self.timer) {
        [self countDownStop];
    }
    
    self.enabled = NO;
    
    self.originalBackgroundColor = self.backgroundColor;
    self.backgroundColor = self.countBackGroundColor;
    
    self.nowTime = self.countDownTime;
    
    [self setTitleColor:self.countTextColor forState:UIControlStateDisabled];
    
    self.originalBorderColor = [UIColor colorWithCGColor:self.layer.borderColor];
    self.layer.borderColor = self.countBorderColor.CGColor;
    
    [self setTitle:[NSString stringWithFormat:@"%@%ld%@",self.countTitlePrefix,self.nowTime,self.countTitleSuffix] forState:UIControlStateDisabled];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}
- (void)countDownPause{
    [self.timer invalidate];
}
- (void)countDownStop{
    [self.timer invalidate];
    self.enabled = YES;
    self.backgroundColor = self.originalBackgroundColor;
    self.layer.borderColor = self.originalBorderColor.CGColor;
}

- (void)timerRun{
    if (self.nowTime == 0) {
        [self countDownStop];
        return;
    }
    self.nowTime --;
    [self setTitle:[NSString stringWithFormat:@"%@%ld%@",self.countTitlePrefix,self.nowTime,self.countTitleSuffix] forState:UIControlStateDisabled];
}


- (NSString *)countTitlePrefix{
    if(!_countTitlePrefix){
        _countTitlePrefix = ({
            NSString * object = [[NSString alloc]init];
            object;
       });
    }
    return _countTitlePrefix;
}

- (NSString *)countTitleSuffix{
    if(!_countTitleSuffix){
        _countTitleSuffix = ({
            NSString * object = [[NSString alloc]init];
            object;
       });
    }
    return _countTitleSuffix;
}

- (UIColor *)countBackGroundColor{
    if(!_countBackGroundColor){
        _countBackGroundColor = ({
            UIColor * object = [UIColor grayColor];
            object;
       });
    }
    return _countBackGroundColor;
}

- (UIColor *)countTextColor{
    if(!_countTextColor){
        _countTextColor = ({
            UIColor * object = [self titleColorForState:UIControlStateNormal];
            object;
       });
    }
    return _countTextColor;
}

- (UIColor *)countBorderColor{
    if(!_countBorderColor){
        _countBorderColor = ({
            UIColor * object = [UIColor colorWithCGColor:self.layer.borderColor];
            object;
       });
    }
    return _countBorderColor;
}

- (UIColor *)originalBackgroundColor{
    if(!_originalBackgroundColor){
        _originalBackgroundColor = ({
            UIColor * object = self.backgroundColor;
            object;
       });
    }
    return _originalBackgroundColor;
}

- (UIColor *)originalBorderColor{
    if(!_originalBorderColor){
        _originalBorderColor = ({
            UIColor * object = [UIColor colorWithCGColor:self.layer.borderColor];
            object;
       });
    }
    return _originalBorderColor;
}
@end

//
//  AMECountDownButton.h
//  ZBEX
//
//  Created by AME on 2018/12/18.
//  Copyright © 2018 ame017. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMECountDownButton : UIButton

@property (nonatomic, copy) IBInspectable NSString * countTitlePrefix;
@property (nonatomic, copy) IBInspectable NSString * countTitleSuffix;
@property (nonatomic, assign) IBInspectable NSInteger countDownTime;
@property (nonatomic, strong) IBInspectable UIColor * countBackGroundColor;
@property (nonatomic, strong) IBInspectable UIColor * countTextColor;
@property (nonatomic, strong) IBInspectable UIColor * countBorderColor;

- (void)countDownStart;
- (void)countDownPause;
- (void)countDownStop;


@end

NS_ASSUME_NONNULL_END

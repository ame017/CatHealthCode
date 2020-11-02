//
//  AMESelectedButton.h
//  HKBTC
//
//  Created by AME on 2019/8/26.
//  Copyright © 2019 ame017. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMESelectedButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor * normal_backgroundColor;
@property (nonatomic, strong) IBInspectable UIColor * selected_backgroundColor;
@property (nonatomic, strong) IBInspectable UIColor * highlighted_backgroundColor;
@property (nonatomic, strong) IBInspectable UIColor * disable_backgroundColor;

@end

NS_ASSUME_NONNULL_END

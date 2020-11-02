//
//  CALayer+Border.m
//  SpaceTime
//
//  Created by AME on 2018/9/19.
//  Copyright © 2018年 Qukuai. All rights reserved.
//

#import "CALayer+Border.h"

@implementation CALayer (Border)
-(void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

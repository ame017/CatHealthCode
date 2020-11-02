//
//  UISearchBar+BackgroundColor.m
//  AMEKit
//
//  Created by AME on 2017/9/8.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "UISearchBar+BackgroundColor.h"

@implementation UISearchBar (BackgroundColor)

- (void)removeBackground{
    [self.subviews[0].subviews[0] removeFromSuperview];
}

@end

//
//  UINavigationItem+Margin.m
//  exhibiton_vino
//
//  Created by Vino－lgc on 2016/11/17.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "UINavigationItem+Margin.h"




@implementation UINavigationItem (Margin)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    NavigationItemMarginManager * manager = [NavigationItemMarginManager sharedManager];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && manager.leftMarginEnable)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = manager.leftMargin;//默认-16
        
        if (_leftBarButtonItem)
        {
            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        }
        else
        {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
        
        
    }
    else
    {
        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    NavigationItemMarginManager * manager = [NavigationItemMarginManager sharedManager];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && manager.rightMarginEnable)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = manager.rightMargin;//默认-12
        
        if (_rightBarButtonItem)
        {
            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
        }
        else
        {
            [self setRightBarButtonItems:@[negativeSeperator]];
        }
        
    }
    else
    {
        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
    }
}

#endif
@end

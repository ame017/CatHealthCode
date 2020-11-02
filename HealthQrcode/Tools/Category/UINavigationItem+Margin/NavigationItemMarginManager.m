//
//  NavigationItemMarginManager.m
//  WYEAPClient
//
//  Created by pc37 on 17/7/25.
//  Copyright © 2017年 pc47. All rights reserved.
//

#import "NavigationItemMarginManager.h"

@implementation NavigationItemMarginManager
NavigationItemMarginManager *_navigationItem_margin_manager;

+ (instancetype)sharedManager{
    @synchronized (self) {
        if (!_navigationItem_margin_manager) {
            _navigationItem_margin_manager = [[NavigationItemMarginManager alloc]init];
            _navigationItem_margin_manager.leftMargin = -16;
            _navigationItem_margin_manager.rightMargin = -12;
        }
        return _navigationItem_margin_manager;
    }
}
@end

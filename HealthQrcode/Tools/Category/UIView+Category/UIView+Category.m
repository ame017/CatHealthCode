//
//  UIView+Category.m
//  TJSWorking
//
//  Created by ame on 2018/3/9.
//  Copyright © 2018年 tejisong. All rights reserved.
//

#import "UIView+Category.h"
#import <objc/runtime.h>

@implementation UIView (Category)

- (nullable __kindof UIView *)ame_subViewOfClassName:(nonnull Class)className{
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView ame_subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

- (nullable __kindof UIView *)ame_superViewOfClassName:(nonnull Class)className{
    UIView * nowView = self;
    UIView * targetView = nil;
    while (nowView.superview != nil) {
        if ([nowView.superview isKindOfClass:className]) {
            targetView = nowView.superview;
            break;
        }
        nowView = nowView.superview;
    }
    return targetView;
}

- (UIImage *)ame_convertViewToImage{
    CGSize s = self.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

//
//  UIScrollView+STAutoHeight.m
//  AUtoLayoutTest
//
//  Created by StriVever on 2017/12/26.
//  Copyright © 2017年 StriVever. All rights reserved.
//

#import "UIScrollView+STAutoHeight.h"
#import <objc/runtime.h>
@implementation UIScrollView (STAutoHeight)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(setContentSize:)), class_getInstanceMethod(self, @selector(st_setContentSize:)));
    });
}


- (void)setIsAutoHeightEnable:(BOOL)isAutoHeightEnable{
    objc_setAssociatedObject(self, @selector(isAutoHeightEnable), @(isAutoHeightEnable), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isAutoHeightEnable{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setSt_maxHeight:(CGFloat)st_maxHeight{
    objc_setAssociatedObject(self, @selector(st_maxHeight), @(st_maxHeight), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)st_maxHeight{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setSt_minHeight:(CGFloat)st_minHeight{
    objc_setAssociatedObject(self, @selector(st_minHeight), @(st_minHeight), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)st_minHeight{
    CGFloat minHeight = [objc_getAssociatedObject(self, _cmd) floatValue];
    return minHeight;
}

- (NSString *)layout_key{
    NSString * layout_key = objc_getAssociatedObject(self, _cmd);
    if (!layout_key) {
        layout_key = st_layout_frame;
        NSArray * sup_layouts = self.superview.constraints;
        for (NSLayoutConstraint * constraint in sup_layouts) {
            if (constraint.firstItem == self || constraint.secondItem == self) {
                NSLog(@"使用了xib");
                layout_key = st_auto_layout;
                break;
            }else continue;
        }
        objc_setAssociatedObject(self, _cmd, layout_key, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return layout_key;
}
- (void)setLayout_key:(NSString *)layout_key{
    objc_setAssociatedObject(self, @selector(layout_key), layout_key, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setHeightConstraint:(NSLayoutConstraint *)heightConstraint{
    objc_setAssociatedObject(self, @selector(heightConstraint), heightConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)heightConstraint{
    NSLayoutConstraint * constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        NSArray * constraints = self.constraints;
        for (NSLayoutConstraint * item in constraints) {
            if (item.firstAttribute == NSLayoutAttributeHeight) {
                constraint = item;
                objc_setAssociatedObject(self, @selector(heightConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                break;
            }
        }
    }
    return constraint;
}



- (void)st_setContentSize:(CGSize)contentSize{
    if (self.isAutoHeightEnable) {
        NSString * key = self.layout_key;
        CGFloat height = contentSize.height;
        CGRect frame = self.frame;
        if (self.st_maxHeight > 0 && height > self.st_maxHeight) {
            height = self.st_maxHeight;
        }
        if (height < self.st_minHeight && self.st_minHeight > 0) {
            height = self.st_minHeight;
        }
        frame.size.height = height;
        if ([key isEqualToString:st_layout_frame]) {
            self.frame = frame;
        }else{
            if (self.heightConstraint) {
                if ([self.heightConstraint isKindOfClass:NSClassFromString(@"NSContentSizeLayoutConstraint")]) {
                    self.scrollEnabled = NO;
                }else{
                    //主动添加了高度约束
                    self.scrollEnabled = YES;
                    self.frame = frame;
                    self.heightConstraint.constant = height;
                }
            }else{
                self.scrollEnabled = NO;
            }
           
        }
    }
     [self st_setContentSize:contentSize];
}
@end

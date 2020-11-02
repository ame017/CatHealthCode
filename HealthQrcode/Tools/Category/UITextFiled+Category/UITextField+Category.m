//
//  UITextField+Category.m
//  ZBEX
//
//  Created by AME on 2018/12/17.
//  Copyright © 2018 ame017. All rights reserved.
//

#import "UITextField+Category.h"
#import <objc/Runtime.h>

IB_DESIGNABLE

@implementation UITextField (Category)
static char * placeholderColorKey = "placeholderColorKey";

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    objc_setAssociatedObject(self, placeholderColorKey, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (@available(iOS 13, *)) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
    }else{
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (UIColor *)placeholderColor{
    if(!objc_getAssociatedObject(self, placeholderColorKey)){
        UIColor *object = [[UIColor alloc]init];
        objc_setAssociatedObject(self, placeholderColorKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, placeholderColorKey);
}
@end

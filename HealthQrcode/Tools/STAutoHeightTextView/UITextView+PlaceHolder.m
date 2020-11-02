//
//  UITextView+PlaceHolder.m
//  AUtoLayoutTest
//
//  Created by StriVever on 2017/12/26.
//  Copyright © 2017年 StriVever. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>
@interface UITextView ()
@property (nonatomic, weak) id st_observer;
@end
@implementation UITextView (PlaceHolder)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self, @selector(st_dealloc)));
        method_exchangeImplementations(class_getInstanceMethod(self, NSSelectorFromString(@"setText:")), class_getInstanceMethod(self, @selector(st_setText:)));
    });
}
- (void)st_dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self.st_observer];
    [self st_dealloc];
}
- (void)st_setText:(NSString *)text{
    [self st_setText:text];
    if (text.length > 0) {
        self.st_placeHolderLabel.hidden = YES;
    }else{
        self.st_placeHolderLabel.hidden = NO;
    }
}
#pragma mark ---setters getters
- (void)setSt_observer:(id)st_observer{
    objc_setAssociatedObject(self, @selector(st_observer), st_observer, OBJC_ASSOCIATION_ASSIGN);
}
- (id)st_observer{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}
- (void)setSt_placeHolder:(NSString *)st_placeHolder{
    if (!st_placeHolder) {
        return;
    }
    if(!self.st_observer){
        __weak typeof(self) weakSelf = self;
       id observer = [[NSNotificationCenter defaultCenter]addObserverForName:UITextViewTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (note.object == strongSelf) {
                if (strongSelf.text.length == 0) {
                    strongSelf.st_placeHolderLabel.hidden = NO;
                }else{
                    strongSelf.st_placeHolderLabel.hidden = YES;
                }
            }
        }];
        self.st_observer = observer;
    }
    objc_setAssociatedObject(self, @selector(st_placeHolder), st_placeHolder, OBJC_ASSOCIATION_COPY);
    self.st_placeHolderLabel.text = st_placeHolder;
}
- (NSString *)st_placeHolder{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSt_placeHolderColor:(UIColor *)st_placeHolderColor{
    objc_setAssociatedObject(self, @selector(st_placeHolderColor), st_placeHolderColor, OBJC_ASSOCIATION_RETAIN);
    self.st_placeHolderLabel.textColor = st_placeHolderColor;
}
- (UIColor *)st_placeHolderColor{
    UIColor * placeholderColor = objc_getAssociatedObject(self, _cmd);
    if (!placeholderColor) {
        placeholderColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    }
    return placeholderColor;
}

- (void)setSt_placeHolderLabel:(UILabel *)st_placeHolderLabel{
    objc_setAssociatedObject(self, @selector(st_placeHolderLabel), st_placeHolderLabel, OBJC_ASSOCIATION_RETAIN);
}
- (UITextView *)st_placeHolderLabel{
    UITextView * placeHolderLabel = objc_getAssociatedObject(self, _cmd);
    if (!placeHolderLabel) {
        placeHolderLabel = [[UITextView alloc]initWithFrame:self.bounds];
        placeHolderLabel.textContainerInset = self.textContainerInset;
        placeHolderLabel.font = self.font;
        placeHolderLabel.userInteractionEnabled = NO;
        placeHolderLabel.backgroundColor = [UIColor clearColor];
        placeHolderLabel.textColor = self.st_placeHolderColor;
        placeHolderLabel.scrollEnabled = NO;
        [self addSubview:placeHolderLabel];
        objc_setAssociatedObject(self, _cmd, placeHolderLabel, OBJC_ASSOCIATION_RETAIN);
    }
    return placeHolderLabel;
}

- (void)setSt_lineSpacing:(CGFloat)st_lineSpacing{
    objc_setAssociatedObject(self, @selector(st_lineSpacing), @(st_lineSpacing), OBJC_ASSOCIATION_ASSIGN);
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = self.st_lineSpacing;// 字体的行间距
    NSMutableDictionary * attributes = self.typingAttributes.mutableCopy;
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.typingAttributes = attributes;
    if (self.text.length > 0) {
        self.text = self.text;
    }
}
- (CGFloat)st_lineSpacing{
    CGFloat line =[objc_getAssociatedObject(self, _cmd) floatValue];
    return line;
}

- (void)setTextViewHeightDidChangedHandle:(void (^)(CGFloat))textViewHeightDidChangedHandle{
    objc_setAssociatedObject(self, @selector(textViewHeightDidChangedHandle), textViewHeightDidChangedHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void(^)(CGFloat textViewHeight))textViewHeightDidChangedHandle{
    return objc_getAssociatedObject(self, _cmd);
}
@end

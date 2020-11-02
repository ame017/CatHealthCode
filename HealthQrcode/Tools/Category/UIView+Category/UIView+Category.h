//
//  UIView+Category.h
//  TJSWorking
//
//  Created by ame on 2018/3/9.
//  Copyright © 2018年 tejisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)



- (nullable __kindof UIView *)ame_subViewOfClassName:(nonnull Class)className;

- (nullable UIImage *)ame_convertViewToImage;

- (nullable __kindof UIView *)ame_superViewOfClassName:(nonnull Class)className;

@end

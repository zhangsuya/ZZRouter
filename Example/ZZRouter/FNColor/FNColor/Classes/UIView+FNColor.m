//
//  UIView+FNColor.m
//  FNMarket
//
//  Created by fuyong on 16/4/5.
//  Copyright © 2016年 cn.com.feiniu. All rights reserved.
//

#import "UIView+FNColor.h"
#import "UIColor+FNColor.h"
#import <objc/runtime.h>

@implementation UIView (FNColor)

- (void)setFn_backgroundColorName:(NSString *)fn_backgroundColorName
{
    UIColor *color = [UIColor fn_colorWithColorKey:fn_backgroundColorName];
    
    objc_setAssociatedObject(self, @selector(fn_backgroundColorName), fn_backgroundColorName, OBJC_ASSOCIATION_COPY);
    
    self.backgroundColor = color;
}

- (NSString *)fn_backgroundColorName
{
    return objc_getAssociatedObject(self, _cmd);
}

@end

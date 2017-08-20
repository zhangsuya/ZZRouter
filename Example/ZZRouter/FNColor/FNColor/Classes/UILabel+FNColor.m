//
//  UILabel+FNColor.m
//  FNMarket
//
//  Created by fuyong on 16/4/5.
//  Copyright © 2016年 cn.com.feiniu. All rights reserved.
//

#import "UILabel+FNColor.h"
#import "UIColor+FNColor.h"
#import <objc/runtime.h>

@implementation UILabel (FNColor)

- (void)setFn_textColorName:(NSString *)fn_textColorName
{
    UIColor *color = [UIColor fn_colorWithColorKey:fn_textColorName];
    objc_setAssociatedObject(self, @selector(fn_textColorName), fn_textColorName, OBJC_ASSOCIATION_COPY);
    self.textColor = color;
}

- (NSString *)fn_textColorName
{
    return objc_getAssociatedObject(self, _cmd);
}

@end

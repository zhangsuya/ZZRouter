//
//  UIViewController+FNColor_navigationBarHidden.m
//  FNMarket
//
//  Created by fuyong on 15/6/8.
//  Copyright (c) 2015年 ZZRouter. All rights reserved.
//

#import "UIViewController+FNNavigationBarHidden.h"
#import <objc/runtime.h>

@implementation UIViewController (FNColor_navigationBarHidden)

- (void)setFnPreferNavigationBarHidden:(BOOL)fnPreferNavigationBarHidden
{
    objc_setAssociatedObject(self, @selector(fnPreferNavigationBarHidden), @(fnPreferNavigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fnPreferNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)fnForbiddenGestureBack
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFnForbiddenGestureBack:(BOOL)fnForbiddenGestureBack
{
    objc_setAssociatedObject(self, @selector(fnForbiddenGestureBack), @(fnForbiddenGestureBack), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

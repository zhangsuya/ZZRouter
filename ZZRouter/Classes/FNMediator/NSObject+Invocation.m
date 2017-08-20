//
//  NSObject+Invocation.m
//  FNMarket
//
//  Created by yongTao on 2017/3/13.
//  Copyright © 2017年 ZZRouter. All rights reserved.
//

#import "NSObject+Invocation.h"

@implementation NSObject (Invocation)

- (id _Nonnull)fn_performSelector:(SEL _Nonnull)aSelector withObject:(id _Nullable)object {
    
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if (!signature) {
        
        return nil;
    }
    NSAssert(!(strcmp(signature.methodReturnType, @encode(void)) != 0 &&
               strcmp(signature.methodReturnType, @encode(id)) != 0), @"返回类型是%s,不是id类型并且不是void", signature.methodReturnType);
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    if (object && signature.numberOfArguments > 2) {
        
        [invocation setArgument:&object atIndex:2];
    }
    [invocation invoke];
    
    if (strcmp(signature.methodReturnType, @encode(id)) != 0) {
        
        return @(YES);
    }
    id __unsafe_unretained unsafeObject = nil;
    [invocation getReturnValue:&unsafeObject];
    id anObject = unsafeObject;
    return anObject;
}

@end

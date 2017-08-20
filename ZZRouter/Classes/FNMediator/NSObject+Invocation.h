//
//  NSObject+Invocation.h
//  FNMarket
//
//  Created by yongTao on 2017/3/13.
//  Copyright © 2017年 ZZRouter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Invocation)

- (id _Nonnull)fn_performSelector:(SEL _Nonnull)aSelector withObject:(id _Nullable)object;

@end

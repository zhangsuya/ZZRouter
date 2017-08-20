//
//  ZZRouterRedirectFactoryProtocol.h
//  ZZRouterDemo
//
//  Created by 张苏亚 on 17/8/3.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZRouterRedirectProtocol.h"

@protocol ZZRouterRedirectFactoryProtocol <NSObject>

+(NSObject<ZZRouterRedirectProtocol> *)redirectObjectByName:(NSString *)forwardName;

@end

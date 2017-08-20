//
//  ZZRouterRedirectFactory.m
//  FNFresh
//
//  Created by 张苏亚 on 17/8/3.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterRedirectFactory.h"

@implementation ZZRouterRedirectFactory

+(NSObject<ZZRouterRedirectProtocol> *)redirectObjectByName:(NSString *)redirectName
{
    NSObject<ZZRouterRedirectProtocol> *redirectObject = (NSObject<ZZRouterRedirectProtocol> *)[[NSClassFromString(redirectName) alloc]init];
    return redirectObject;
}

@end

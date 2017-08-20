//
//  ZZRouterSequentialIndependenceFactory.m
//  ZZRouterDemo
//
//  Created by 张苏亚 on 17/8/8.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "ZZRouterSequentialIndependenceFactory.h"

@implementation ZZRouterSequentialIndependenceFactory

+(NSObject<ZZRouterSequentialIndependenceProtocol> *)sequentialIndependenceObjectByName:(NSString *)sequentialIndependenceName
{
    NSObject<ZZRouterSequentialIndependenceProtocol> *sequentialIndependenceObject = (NSObject<ZZRouterSequentialIndependenceProtocol> *)[[NSClassFromString(sequentialIndependenceName) alloc]init];
    return sequentialIndependenceObject;
}

@end

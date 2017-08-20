//
//  ZZRouterSequentialIndependenceFactoryProtocol.h
//  ZZRouterDemo
//
//  Created by 张苏亚 on 17/8/9.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZRouterSequentialIndependenceProtocol.h"
@protocol ZZRouterSequentialIndependenceFactoryProtocol <NSObject>

+(NSObject<ZZRouterSequentialIndependenceProtocol> *)sequentialIndependenceObjectByName:(NSString *)sequentialIndependenceName;

@end

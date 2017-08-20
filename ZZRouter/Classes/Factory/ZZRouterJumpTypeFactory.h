//
//  ZZRouterJumpTypeFactory.h
//  FNFresh
//
//  Created by 张苏亚 on 17/7/18.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZRouterJumpTypeFactoryProtocol.h"
#import "ZZRouterJumpTypeProtocol.h"

@interface ZZRouterJumpTypeFactory : NSObject<ZZRouterJumpTypeFactoryProtocol>

+ (ZZRouterJumpTypeFactory*)sharedInstance;

//+(NSObject<ZZRouterJumpTypeProtocol> *)jumpTypeObjectByName:(NSString *)typeName;


@end

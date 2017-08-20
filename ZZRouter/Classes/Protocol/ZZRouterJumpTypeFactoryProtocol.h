//
//  ZZRouterJumpTypeFactoryProtocol.h
//  ZZRouter
//
//  Created by 张苏亚 on 17/7/18.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZRouterJumpTypeProtocol.h"

@protocol ZZRouterJumpTypeFactoryProtocol <NSObject>

@required

+(NSObject<ZZRouterJumpTypeProtocol> *)jumpTypeObjectByName:(NSString *)typeName;
@end

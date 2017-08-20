//
//  ZZRouterJumpTypeProtocol.h
//  ZZRouter
//
//  Created by 张苏亚 on 17/5/22.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZRouterJumpTypeModelProtocol.h"
#import <UIKit/UIKit.h>

@protocol ZZRouterJumpTypeProtocol <NSObject>

-(void)jumpWithTypeModel:(NSObject<ZZRouterJumpTypeModelProtocol> *)model;

-(void)jumpWithTypeVC:(UIViewController *)typeVC;




@end

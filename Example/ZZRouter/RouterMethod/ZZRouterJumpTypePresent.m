//
//  ZZRouterJumpTypePresent.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/1.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypePresent.h"
#import "ZZRouterTabBarController.h"

@implementation ZZRouterJumpTypePresent

-(void)jumpWithTypeModel:(NSObject<ZZRouterJumpTypeModelProtocol> *)model
{
    [[ZZRouterTabBarController shareInstance] presentViewController:model.vc animated:YES completion:nil];
}

-(void)jumpWithTypeVC:(UIViewController *)typeVC
{
    [[ZZRouterTabBarController shareInstance] presentViewController:typeVC animated:YES completion:nil];
}

@end

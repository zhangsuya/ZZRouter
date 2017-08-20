//
//  ZZRouterJumpTypePresent.m
//  FNFresh
//
//  Created by 张苏亚 on 17/8/1.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypePresent.h"
#import "FNFreshTabBarController.h"

@implementation ZZRouterJumpTypePresent

-(void)jumpWithTypeModel:(NSObject<ZZRouterJumpTypeModelProtocol> *)model
{
    [[FNFreshTabBarController shareInstance] presentViewController:model.vc animated:YES completion:nil];
}

-(void)jumpWithTypeVC:(UIViewController *)typeVC
{
    [[FNFreshTabBarController shareInstance] presentViewController:typeVC animated:YES completion:nil];
}

@end

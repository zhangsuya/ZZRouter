//
//  ZZRouterJumpTypeHideTabBarWhenPush.m
//  FNFresh
//
//  Created by 张苏亚 on 17/8/2.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypeHideTabBarWhenPush.h"
#import "FNFreshTabBarController.h"

@implementation ZZRouterJumpTypeHideTabBarWhenPush

-(void)jumpWithTypeModel:(NSObject<ZZRouterJumpTypeModelProtocol> *)model
{
    [FNFreshTabBarController shareInstance].hidesBottomBarWhenPushed = YES;
    [[FNFreshTabBarController shareInstance].navigationController pushViewController:model.vc animated:YES];
}

-(void)jumpWithTypeVC:(UIViewController *)typeVC
{
    [FNFreshTabBarController shareInstance].hidesBottomBarWhenPushed = YES;
    [[FNFreshTabBarController shareInstance].navigationController pushViewController:typeVC animated:YES];
}

@end

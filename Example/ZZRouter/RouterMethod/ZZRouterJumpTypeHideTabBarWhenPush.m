//
//  ZZRouterJumpTypeHideTabBarWhenPush.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/2.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypeHideTabBarWhenPush.h"
#import "ZZRouterTabBarController.h"

@implementation ZZRouterJumpTypeHideTabBarWhenPush

-(void)jumpWithTypeModel:(NSObject<ZZRouterJumpTypeModelProtocol> *)model
{
    [ZZRouterTabBarController shareInstance].hidesBottomBarWhenPushed = YES;
    [[ZZRouterTabBarController shareInstance].navigationController pushViewController:model.vc animated:YES];
}

-(void)jumpWithTypeVC:(UIViewController *)typeVC
{
    [ZZRouterTabBarController shareInstance].hidesBottomBarWhenPushed = YES;
    [[ZZRouterTabBarController shareInstance].navigationController pushViewController:typeVC animated:YES];
}

@end

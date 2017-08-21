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



-(void)jumpWithTypeVC:(UIViewController *)typeVC paramsDict:(NSDictionary *)params
{
    [ZZRouterTabBarController shareInstance].hidesBottomBarWhenPushed = YES;
    [[ZZRouterTabBarController shareInstance].navigationController pushViewController:typeVC animated:YES];
}

@end

//
//  ZZRouterJumpTypePush.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/1.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypePush.h"
#import "ZZRouterTabBarController.h"

@implementation ZZRouterJumpTypePush

-(void)jumpWithTypeVC:(UIViewController *)typeVC paramsDict:(NSDictionary *)params
{
    [[ZZRouterTabBarController shareInstance].navigationController pushViewController:typeVC animated:YES];
}

@end

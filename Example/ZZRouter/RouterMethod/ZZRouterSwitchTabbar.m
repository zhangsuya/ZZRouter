//
//  ZZRouterSwitchTabbar.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/21.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "ZZRouterSwitchTabbar.h"
#import "FNMediator+TabBar.h"

@implementation ZZRouterSwitchTabbar

-(void)jumpWithTypeVC:(UIViewController *)typeVC paramsDict:(NSDictionary *)params
{
    NSString *tabItemIndex = [params objectForKey:@"tabItemIndex"];
    
    [[FNMediator sharedInstance] TabBarService_InitWithTabBarItem:tabItemIndex];
}

@end

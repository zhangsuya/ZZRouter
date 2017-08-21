//
//  FNMediator+TabBar.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/21.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "FNMediator+TabBar.h"

NSString *Parameter_TabBarItem = @"tabItemIndex";

static NSString *const Target_ZZRouterTarget_TabBarService = @"TabBarService";


static NSString *const Action_ZZRouterTabBarController_InitWithParams = @"ZZRouterTabBarController_SwitchTabBarWithParam";

@implementation FNMediator (TabBar)

- (void)TabBarService_InitWithTabBarItem:(NSString *)tabItem
{
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    if (tabItem) {
        
        [parameter setObject:tabItem forKey:Parameter_TabBarItem];
    }
    
    [self performTarget:Target_ZZRouterTarget_TabBarService action:Action_ZZRouterTabBarController_InitWithParams params:parameter];

}

@end

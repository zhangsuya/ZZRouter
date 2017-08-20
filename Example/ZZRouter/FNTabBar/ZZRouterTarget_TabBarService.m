//
//  ZZRouterTarget_TabBarService.m
//  ZZRouter
//
//  Created by JamesCorp on 2017/4/13.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterTarget_TabBarService.h"
#import "ZZRouterTabBarController.h"

@implementation ZZRouterTarget_TabBarService
-(void)action_ZZRouterTabBarController_SwitchTabBarWithParam:(id)param{
    NSString *tabItemIndex = [(NSDictionary*)param objectForKey:@"tabItemIndex"];
    if (tabItemIndex) {
        [[ZZRouterTabBarController shareInstance] backToHomeViewAnimated:YES];
        [[ZZRouterTabBarController shareInstance] switchTabBarWithParam:param];
    }
    
}
@end

//
//  FNMediator+FNUserCenterModule.m
//  ZZRouter
//
//  Created by litt1er on 17/4/26.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNMediator+FNUserCenterModule.h"

NSString *Parameter_LoginBlock = @"Parameter_LoginBlock";

static NSString *const Target_ZZRouterTarget_LoginModule = @"LoginModule";
static NSString *const Target_ZZRouterTarget_RegisterModule = @"RegisterModule";

static NSString *const Action_ZZRouterLoginParentViewController_InitWithParams = @"ZZRouterLoginParentViewController_InitWithParams";
static NSString *const Action_ZZRouterRegisterViewController_Init = @"ZZRouterRegisterViewController_Init";


@implementation FNMediator (FNUserCenterModule)

- (UIViewController *)LoginModule_InitWithComplete:(void (^)())complete
{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    if (complete) {
        
        [parameter setObject:complete forKey:Parameter_LoginBlock];
    }
    return [self performTarget:Target_ZZRouterTarget_LoginModule action:Action_ZZRouterLoginParentViewController_InitWithParams params:parameter];
}


- (UIViewController *)RegisterModule_Init
{
    return [self performTarget:Target_ZZRouterTarget_RegisterModule action:Action_ZZRouterRegisterViewController_Init params:nil];
}

@end

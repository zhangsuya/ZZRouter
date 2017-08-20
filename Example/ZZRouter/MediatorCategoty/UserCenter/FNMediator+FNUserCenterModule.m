//
//  FNMediator+FNUserCenterModule.m
//  FNFresh
//
//  Created by litt1er on 17/4/26.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNMediator+FNUserCenterModule.h"

NSString *Parameter_LoginBlock = @"Parameter_LoginBlock";

static NSString *const Target_FNFreshTarget_LoginModule = @"LoginModule";
static NSString *const Target_FNFreshTarget_RegisterModule = @"RegisterModule";

static NSString *const Action_FNFreshLoginParentViewController_InitWithParams = @"FNFreshLoginParentViewController_InitWithParams";
static NSString *const Action_FNFreshRegisterViewController_Init = @"FNFreshRegisterViewController_Init";


@implementation FNMediator (FNUserCenterModule)

- (UIViewController *)LoginModule_InitWithComplete:(void (^)())complete
{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    if (complete) {
        
        [parameter setObject:complete forKey:Parameter_LoginBlock];
    }
    return [self performTarget:Target_FNFreshTarget_LoginModule action:Action_FNFreshLoginParentViewController_InitWithParams params:parameter];
}


- (UIViewController *)RegisterModule_Init
{
    return [self performTarget:Target_FNFreshTarget_RegisterModule action:Action_FNFreshRegisterViewController_Init params:nil];
}

@end

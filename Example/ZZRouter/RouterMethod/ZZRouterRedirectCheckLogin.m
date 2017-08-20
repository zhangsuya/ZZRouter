//
//  ZZRouterRedirctCheckLogin.m
//  FNFresh
//
//  Created by 张苏亚 on 17/8/2.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterRedirectCheckLogin.h"
#import "FNMediator.h"
#import "FNFreshUser.h"
#import "FNMediator+FNUserCenterModule.h"
#import "FNFreshTabBarController.h"

@implementation ZZRouterRedirectCheckLogin

-(void)redirectByOriginalVC:(UIViewController *)originalVC originalVCBlock:(OriginalVCJumpAction)jumpAction
{
    if ([FNFreshUser shareInstance].isLogin) {
        jumpAction(originalVC);
    } else {
        [ZZRouterRedirectCheckLogin transtionToLoginVC:^{
            jumpAction(originalVC);
        }];
    }
}


+ (void)transtionToLoginVC:(void(^)(void))loginBlock
{
    UIViewController *navigationVC = [[FNMediator sharedInstance] LoginModule_InitWithComplete:loginBlock];
    
    [[FNFreshTabBarController shareInstance].navigationController presentViewController:navigationVC animated:YES completion:^{
        
    }];
    
    
}
@end

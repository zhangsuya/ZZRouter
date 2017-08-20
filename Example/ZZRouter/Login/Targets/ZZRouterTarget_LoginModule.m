//
//  ZZRouterTarget_LoginModule.m
//  ZZRouter
//
//  Created by JamesCorp on 2017/4/26.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterTarget_LoginModule.h"
#import "ZZRouterLoginParentViewController.h"
#import "FNBaseNavigationController.h"
#import "BFKit.h"

typedef void (^reloadWebViewCallback)(NSString *urlString);


@implementation ZZRouterTarget_LoginModule

//本地调用loginVC
- (UIViewController *)action_ZZRouterLoginParentViewController_InitWithParams:(NSDictionary *)params
{
    ZZRouterLoginParentViewController *viewController = [[ZZRouterLoginParentViewController alloc] init];
    viewController.loginBlock = [params safeObjectForKey:Parameter_LoginBlock];
    FNBaseNavigationController *navigationController = [[FNBaseNavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (UIViewController *)action_ZZRouterLoginParentViewController_InitWithParam:(NSDictionary *)params{
    NSString *sourceUrl = [params objectForKey:@"url"];
    
    NSString *url = params[@"url"];
    reloadWebViewCallback reloadBlock = params[@"h5Refresh"];
    ZZRouterLoginParentViewController *loginVC = [[ZZRouterLoginParentViewController alloc] init];
    loginVC.loginBlock =^{
        if (url) {
            reloadBlock(url);
        }
    };
    FNBaseNavigationController *navigationController = [[FNBaseNavigationController alloc] initWithRootViewController:loginVC];
    return navigationController;
}


@end

//
//  FNFreshTarget_LoginModule.m
//  FNFresh
//
//  Created by JamesCorp on 2017/4/26.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNFreshTarget_LoginModule.h"
#import "FNFreshLoginParentViewController.h"
#import "FNBaseNavigationController.h"
#import "BFKit.h"

typedef void (^reloadWebViewCallback)(NSString *urlString);


@implementation FNFreshTarget_LoginModule

//本地调用loginVC
- (UIViewController *)action_FNFreshLoginParentViewController_InitWithParams:(NSDictionary *)params
{
    FNFreshLoginParentViewController *viewController = [[FNFreshLoginParentViewController alloc] init];
    viewController.loginBlock = [params safeObjectForKey:Parameter_LoginBlock];
    FNBaseNavigationController *navigationController = [[FNBaseNavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (UIViewController *)action_FNFreshLoginParentViewController_InitWithParam:(NSDictionary *)params{
    NSString *sourceUrl = [params objectForKey:@"url"];
    
    NSString *url = params[@"url"];
    reloadWebViewCallback reloadBlock = params[@"h5Refresh"];
    FNFreshLoginParentViewController *loginVC = [[FNFreshLoginParentViewController alloc] init];
    loginVC.loginBlock =^{
        if (url) {
            reloadBlock(url);
        }
    };
    FNBaseNavigationController *navigationController = [[FNBaseNavigationController alloc] initWithRootViewController:loginVC];
    return navigationController;
}


@end

//
//  FNFreshTarget_LoginModule.h
//  FNFresh
//
//  Created by JamesCorp on 2017/4/26.
//  Copyright © 2017年ZZRouter All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *Parameter_LoginBlock;


@interface FNFreshTarget_LoginModule : NSObject

//本地调用loginVC
- (UIViewController *)action_FNFreshLoginParentViewController_InitWithParams:(NSDictionary *)params;


/**
 登陆

 @param params @{
    @"url":<#原始h5页面url#>
 }
 @return 登陆view controller
 */
-(UIViewController *)action_FNFreshLoginParentViewController_InitWithParam:(NSDictionary *)params;

@end

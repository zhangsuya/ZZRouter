//
//  ZZRouterJumpTypePush.m
//  FNFresh
//
//  Created by 张苏亚 on 17/8/1.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypePush.h"
#import "FNFreshTabBarController.h"

@implementation ZZRouterJumpTypePush

-(void)jumpWithTypeModel:(NSObject<ZZRouterJumpTypeModelProtocol> *)model
{
    [[FNFreshTabBarController shareInstance].navigationController pushViewController:model.vc animated:YES];

}

-(void)jumpWithTypeVC:(UIViewController *)typeVC
{
    [[FNFreshTabBarController shareInstance].navigationController pushViewController:typeVC animated:YES];
}

@end

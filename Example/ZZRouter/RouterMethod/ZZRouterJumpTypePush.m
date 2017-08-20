//
//  ZZRouterJumpTypePush.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/1.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypePush.h"
#import "ZZRouterTabBarController.h"

@implementation ZZRouterJumpTypePush

-(void)jumpWithTypeModel:(NSObject<ZZRouterJumpTypeModelProtocol> *)model
{
    [[ZZRouterTabBarController shareInstance].navigationController pushViewController:model.vc animated:YES];

}

-(void)jumpWithTypeVC:(UIViewController *)typeVC
{
    [[ZZRouterTabBarController shareInstance].navigationController pushViewController:typeVC animated:YES];
}

@end

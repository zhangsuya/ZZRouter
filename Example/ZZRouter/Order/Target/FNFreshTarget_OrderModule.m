//
//  FNFreshTarget_OrderModule.m
//  FNFresh
//
//  Created by JamesCorp on 2017/4/13.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNFreshTarget_OrderModule.h"
#import "FNFreshMyOrdersViewController.h"

@implementation FNFreshTarget_OrderModule


- (UIViewController*)action_FNFreshMyOrdersViewController_InitWithParam:(NSDictionary *)param {
//    NSString *orderType = [param objectForKey:@"type"];
    return [[FNFreshMyOrdersViewController alloc] init];
}

@end

//
//  ZZRouterTarget_OrderModule.m
//  ZZRouter
//
//  Created by JamesCorp on 2017/4/13.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterTarget_OrderModule.h"
#import "ZZRouterMyOrdersViewController.h"

@implementation ZZRouterTarget_OrderModule


- (UIViewController*)action_ZZRouterMyOrdersViewController_InitWithParam:(NSDictionary *)param {
    NSString *orderId = [param objectForKey:@"orderid"];
    return [[ZZRouterMyOrdersViewController alloc] initWithOrderId:orderId];
}

@end

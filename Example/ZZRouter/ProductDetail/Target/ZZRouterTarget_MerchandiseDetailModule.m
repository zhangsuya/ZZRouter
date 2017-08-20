//
//  FNTarget_MerchandiseDetail.m
//  ZZRouter
//
//  Created by Minyoung  on 2017/4/13.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterTarget_MerchandiseDetailModule.h"
#import "ZZRouterProductDetailViewController.h"

@implementation ZZRouterTarget_MerchandiseDetailModule

/**
 商祥vc
 @param parameter
 @{
 @"smSeq":<#商品id required#>
 @"serviceId":<#加工服务id optional#>
 }
 @return vc
 */
- (UIViewController *)action_ZZRouterProductDetailViewController_InitializeWithParameter:(NSDictionary *)parameter {
    NSString *smSeq = [parameter objectForKey:@"smseq"];
    NSString *serviceId = [parameter objectForKey:@"serviceId"];
    return [[ZZRouterProductDetailViewController alloc] initWithMerchandiseId:smSeq serviceId:serviceId];
}

@end

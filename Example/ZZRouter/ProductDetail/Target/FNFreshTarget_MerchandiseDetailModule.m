//
//  FNTarget_MerchandiseDetail.m
//  FNFresh
//
//  Created by Minyoung  on 2017/4/13.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNFreshTarget_MerchandiseDetailModule.h"
#import "FNFreshProductDetailViewController.h"

@implementation FNFreshTarget_MerchandiseDetailModule

/**
 商祥vc
 @param parameter
 @{
 @"smSeq":<#商品id required#>
 @"serviceId":<#加工服务id optional#>
 }
 @return vc
 */
- (UIViewController *)action_FNFreshProductDetailViewController_InitializeWithParameter:(NSDictionary *)parameter {
    NSString *smSeq = [parameter objectForKey:@"smseq"];
    NSString *serviceId = [parameter objectForKey:@"serviceId"];
    return [[FNFreshProductDetailViewController alloc] initWithMerchandiseId:smSeq serviceId:serviceId];
}

@end

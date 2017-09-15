//
//  FNMediator+ProdouctDetail.m
//  ZZRouter
//
//  Created by 张苏亚 on 2017/9/15.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "FNMediator+ProdouctDetail.h"

static NSString * const kProductDetailModuleKey = @"MerchandiseDetailModule";

static NSString * const kProductDetailControllerActionKey = @"ZZRouterProductDetailViewController_InitializeWithParameter";
@implementation FNMediator (ProdouctDetail)

- (UIViewController *)prodouctDetail_InitializeWithMerchandiseId:(NSString *)merchandiseId serviceId:(NSString *)serviceId
{
    NSAssert(merchandiseId, @"商品id为空");
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithObject:merchandiseId?:@"" forKey:@"smseq"];
    if (serviceId) {
        [parameter setObject:serviceId forKey:@"serviceId"];
    }
    
    UIViewController *productDetailVc = [self performTarget:kProductDetailModuleKey action:kProductDetailControllerActionKey params:parameter];
    return productDetailVc;
}

@end

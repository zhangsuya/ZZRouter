//
//  FNMediator+ProdouctDetail.h
//  ZZRouter
//
//  Created by 张苏亚 on 2017/9/15.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import <ZZRouter/ZZRouter.h>
#import "FNMediator.h"

@interface FNMediator (ProdouctDetail)

/**
 商祥vc
 @param merchandiseId 商品id required
 @param serviceId <#加工服务id optional#>
 @return vc
 */
- (UIViewController *)prodouctDetail_InitializeWithMerchandiseId:(NSString *)merchandiseId serviceId:(NSString *)serviceId;


@end

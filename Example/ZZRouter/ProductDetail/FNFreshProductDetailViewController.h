//
//  FNFreshProductDetailViewController.h
//  ZZRouterDemo
//
//  Created by 张苏亚 on 17/8/3.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNFreshProductDetailViewController : UIViewController

/**
 商祥初始化方法
 
 @param merchandiseId 商品id required
 @param serviceId 加工服务id optional
 @return vc
 */
- (instancetype)initWithMerchandiseId:(NSString *)merchandiseId serviceId:(NSString *)serviceId;

@end

//
//  FNFreshTarget_OrderModule.h
//  FNFresh
//
//  Created by JamesCorp on 2017/4/13.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FNFreshTarget_OrderModule : NSObject

/**
 我的订单VC

 @param param 字典参数
 @return 我的订单VC
 */
- (UIViewController*)action_FNFreshMyOrdersViewController_InitWithParam:(NSDictionary *)param;

@end

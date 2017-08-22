//
//  ZZRouterMyOrdersViewController.h
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/22.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZRouterMyOrdersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;

-(instancetype)initWithOrderId:(NSString *)orderId;


@end

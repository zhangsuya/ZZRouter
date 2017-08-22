//
//  ZZRouterMyOrdersViewController.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/22.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "ZZRouterMyOrdersViewController.h"

@interface ZZRouterMyOrdersViewController ()

@property (nonatomic, copy)NSString *orderId;

@end

@implementation ZZRouterMyOrdersViewController

-(instancetype)initWithOrderId:(NSString *)orderId
{
    if (self = [super init]) {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    if (self.orderId != nil) {
        self.orderIdLabel.text = [NSString stringWithFormat:@"orderid:%@",self.orderId];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ZZRouterMrFreshViewController.m
//  ZZRouterDemo
//
//  Created by 张苏亚 on 17/8/3.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "ZZRouterMrFreshViewController.h"
#import "ZZRouterProductDetailViewController.h"
#import "ZZRouterTabBarController.h"
#import "FNMediator+ProdouctDetail.h"

@interface ZZRouterMrFreshViewController ()

@end

@implementation ZZRouterMrFreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)btnClicked:(id)sender {
    
    ZZRouterProductDetailViewController *productDetailVC = (ZZRouterProductDetailViewController *)[[FNMediator sharedInstance] prodouctDetail_InitializeWithMerchandiseId:@"" serviceId:@""];
    [[ZZRouterTabBarController shareInstance].navigationController pushViewController:productDetailVC animated:YES];

}
@end

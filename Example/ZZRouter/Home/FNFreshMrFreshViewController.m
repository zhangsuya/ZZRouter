//
//  FNFreshMrFreshViewController.m
//  ZZRouterDemo
//
//  Created by 张苏亚 on 17/8/3.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "FNFreshMrFreshViewController.h"
#import "FNFreshProductDetailViewController.h"
#import "FNFreshTabBarController.h"

@interface FNFreshMrFreshViewController ()

@end

@implementation FNFreshMrFreshViewController

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
    
    FNFreshProductDetailViewController *productDetailVC = [[FNFreshProductDetailViewController alloc] init];
    [[FNFreshTabBarController shareInstance].navigationController pushViewController:productDetailVC animated:YES];

}
@end

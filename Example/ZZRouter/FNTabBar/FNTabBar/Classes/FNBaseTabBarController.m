//
//  FNFreshTabBarController.m
//  FNTabBarDemo_test
//
//  Created by 张三松 on 16/9/5.
//  Copyright © 2017年 FeiNiu. All rights reserved.
//

#import "FNBaseTabBarController.h"
#import "FNTabBar.h"

@interface FNBaseTabBarController ()

@property (nonatomic, assign)NSUInteger index;

@end

@implementation FNBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FNTabBar *fnTabBar = [[FNTabBar alloc]init];
    [self setValue:fnTabBar forKey:@"tabBar"];
    
    //点击回调
    __weak typeof(self)weakSelf = self;
    [fnTabBar addCustomeButtonBlock:^(NSUInteger index) {
        [weakSelf performDelegateActionWithIndex:index];
    }];
}

//执行代理方法
- (void)performDelegateActionWithIndex:(NSUInteger )index {
    BOOL isChange = YES;
    if (self.fnBaseTabBarControllerDelegate && [self.fnBaseTabBarControllerDelegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        isChange =  [self.fnBaseTabBarControllerDelegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]];
    }
    
    [self saveObject:@(isChange) forKey:@"tabBar_change_delegate"];
    
    if (self.fnBaseTabBarControllerDelegate && [self.fnBaseTabBarControllerDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        if (isChange) {
            [self.fnBaseTabBarControllerDelegate tabBarController:self didSelectViewController:[self.viewControllers objectAtIndex:index]];
        }
    }
}

- (void)saveObject:(id )object forKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:object forKey:key];
    [user synchronize];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

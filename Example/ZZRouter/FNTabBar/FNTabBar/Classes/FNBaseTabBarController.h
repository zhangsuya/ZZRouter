//
//  FNFreshTabBarController.h
//  FNTabBarDemo_test
//
//  Created by 张三松 on 16/9/5.
//  Copyright © 2017年 FeiNiu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  外部自定义tabBarController继承于FNFreshTabBarController，并遵循FNFreshTabBarControllerDelegate协议
 */

@protocol FNBaseTabBarControllerDelegate <NSObject>

@optional
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end


@interface FNBaseTabBarController : UITabBarController

@property(weak, nonatomic)id<FNBaseTabBarControllerDelegate>fnBaseTabBarControllerDelegate;


@end

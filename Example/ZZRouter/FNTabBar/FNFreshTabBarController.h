//
//  FNFreshTabBarController.h
//  FNFresh
//
//  Created by DC on 2017/2/8.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNBaseTabBarController.h"

typedef NS_ENUM(NSUInteger, FNTabBarViewControllerType) {
    FNTabBarViewControllerTypeHome = 0,         // 首页
    FNTabBarViewControllerTypeDepartments,      // 分类
    FNTabBarViewControllerTypeShoppingCart,     // 购物车
    FNTabBarViewControllerTypeMyAccount         // 我的账户
};

@interface FNFreshTabBarController : FNBaseTabBarController

+ (instancetype)shareInstance;

- (void)createControllers;

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)backToHomeViewAnimated:(BOOL)flag;

- (void)switchTabBarWithParam:(NSDictionary*)param;

/** 返回并展示对应的Controller */
- (void)backToTagetViewControllerWithType:(FNTabBarViewControllerType)type animated:(BOOL)animated;

/** 获取TabBar上对应Controller */
- (UIViewController *)viewControllerInTabBarWithType:(FNTabBarViewControllerType)type;
/** 更新购物车总数量 */
-(void)updateBadgeFinal:(NSString *)finalCount;
/** 购物车总数量置成0 */
-(void)updateBadge2Zero;
/** 获取购物车总数量 */
- (NSString *)getBadge;

@end

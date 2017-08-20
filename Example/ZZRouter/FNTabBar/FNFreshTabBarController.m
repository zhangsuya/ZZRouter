//
//  FNFreshTabBarController.m
//  FNFresh
//
//  Created by DC on 2017/2/8.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNFreshTabBarController.h"
#import "FNBaseNavigationController.h"
#import "FNFreshMrFreshViewController.h"
#import "FNTabBar.h"
#import "FNFreshUser.h"
#import "UIFont+FNFont.h"
#import "UIColor+FNColor.h"
#import "BFKit.h"

@interface FNFreshTabBarController ()<FNBaseTabBarControllerDelegate>

@property (nonatomic, strong) FNTabBar *fnTabBar;

@property (nonatomic, copy) NSString *totalCount;

@end

@implementation FNFreshTabBarController

+ (instancetype) shareInstance {
    static FNFreshTabBarController *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[FNFreshTabBarController alloc] init];
    });
    return _shareInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createControllers];
    self.fnBaseTabBarControllerDelegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _fnTabBar = (FNTabBar *)self.tabBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)createControllers
{
    [self FNAddChildViewController:[[FNFreshMrFreshViewController alloc] init] title:@"首页" image:[UIImage imageNamed:@"icon_Home_n"] selectedImage:[UIImage imageNamed:@"icon_home_s"]];
    [self FNAddChildViewController:[[FNFreshMrFreshViewController alloc] init] title:@"分类" image:[UIImage imageNamed:@"icon_classification_n"] selectedImage:[UIImage imageNamed:@"icon_classification_s"]];
    [self FNAddChildViewController:[[FNFreshMrFreshViewController alloc] init] title:@"购物车" image:[UIImage imageNamed:@"icon_shoppingcat_n"] selectedImage:[UIImage imageNamed:@"icon_shoppingcat_s"]];
    [self FNAddChildViewController:[[FNFreshMrFreshViewController alloc] init] title:@"我的" image:[UIImage imageNamed:@"icon_my_n"] selectedImage:[UIImage imageNamed:@"icon_my_s"]];
}

- (void)FNAddChildViewController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    UIViewController *chilrdVC =  [self FNConfigureChildViewController:controller title:title image:image selectedImage:selectedImage];
    [self addChildViewController:chilrdVC];
}


- (UIViewController *)FNConfigureChildViewController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    controller.tabBarItem.title = title;
    [controller.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fn_FontWithFontKey:kFC_E],NSForegroundColorAttributeName:[UIColor fn_colorWithColorKey:FNColor_Light_Grey]} forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fn_FontWithFontKey:kFC_E],NSForegroundColorAttributeName:[UIColor fn_colorWithColorKey:FNColor_Main_Color]} forState:UIControlStateSelected];
    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    controller.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return controller;
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[FNFreshTabBarController shareInstance] pushViewController:viewController animated:animated];
}

- (void)backToHomeViewAnimated:(BOOL)flag
{
    [self backToTagetViewControllerWithType:FNTabBarViewControllerTypeHome animated:flag];
}

- (void)backToTagetViewControllerWithType:(FNTabBarViewControllerType)type animated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
    [self.navigationController dismissViewControllerAnimated:animated completion:nil];
    [self setSelectedIndex:type];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.navigationController) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (UIViewController *)viewControllerInTabBarWithType:(FNTabBarViewControllerType)type;
{
    return [self.viewControllers safeObjectAtIndex:type];
}

- (void)switchTabBarWithParam:(NSDictionary*)param{
    NSInteger tabItemIndex = [[param objectForKey:@"tabItemIndex"] integerValue];
    if (tabItemIndex>=0&&tabItemIndex<4) {
        [self setSelectedIndex:tabItemIndex];
        switch (tabItemIndex) {
            case 0:{
                if ([self.selectedViewController isKindOfClass:[FNFreshMrFreshViewController class]]&&[[param objectForKey:@"isrefresh"] integerValue]==1) {
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[FNFreshMrFreshViewController class]]) {
        
//        [(FNFreshMrFreshViewController *)viewController scrollToTop];
    }
}

#pragma mark - shopCartCount
-(void)updateBadgeFinal:(NSString *)finalCount
{
    [_fnTabBar fn_showNumber:finalCount atItemIndext:2];
    _totalCount = finalCount;
}

-(void)updateBadge2Zero
{
    [_fnTabBar fn_removeBadgeNumberAtItemIndex:2];
    _totalCount = @"0";
}

- (NSString *)getBadge
{
    if ([_totalCount intValue] > 99) {
         return @"99+";
    }

    return _totalCount;
}


@end

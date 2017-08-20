//
//  FNBaseNavigationController.m
//  FNFresh
//
//  Created by DC on 2017/2/7.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNBaseNavigationController.h"
#import "UIViewController+FNNavigationBarHidden.h"

@interface FNBaseNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL hidden;

@end

@implementation FNBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakself;
        self.delegate = weakself;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.hidden) {
        
        self.hidden = NO;
        [self setNavigationBarHidden:YES animated:NO];
        self.navigationBar.hidden = NO;
    }
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        if ([viewController respondsToSelector:@selector(back)]) {
            viewController.navigationItem.leftBarButtonItem = [self itemWithImageName:@"icon_return_listpage" highImageName:@"icon_return_listpage" target:viewController action:@selector(back)];
        } else {
            viewController.navigationItem.leftBarButtonItem = [self itemWithImageName:@"icon_return_listpage" highImageName:@"icon_return_listpage" target:self action:@selector(back)];
        }
        
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    self.hidden = viewController.fnPreferNavigationBarHidden && self.topViewController.fnPreferNavigationBarHidden;
    if (self.hidden) {
        
        [self setNavigationBarHidden:NO animated:NO];
        self.navigationBar.hidden = YES;
    }
    return viewController;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSArray <UIViewController *>*viewControllers = [super popToViewController:viewController animated:animated];
    self.hidden = viewControllers.lastObject.fnPreferNavigationBarHidden && viewController.fnPreferNavigationBarHidden;
    if (self.hidden) {
        
        [self setNavigationBarHidden:NO animated:NO];
        self.navigationBar.hidden = YES;
    }
    return viewControllers;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    
    NSArray <UIViewController *>*viewControllers = [super popToRootViewControllerAnimated:animated];
    self.hidden = viewControllers.lastObject.fnPreferNavigationBarHidden && self.topViewController.fnPreferNavigationBarHidden;
    if (self.hidden) {
        
        [self setNavigationBarHidden:NO animated:NO];
        self.navigationBar.hidden = YES;
    }
    return viewControllers;
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];

    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];

    CGRect frame = button.frame;
    frame.size = CGSizeMake(button.currentImage.size.width*2, button.currentImage.size.height) ;
    button.frame = frame;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, button.currentImage.size.width);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
     [viewController.navigationController setNavigationBarHidden:viewController.fnPreferNavigationBarHidden animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (viewController.fnForbiddenGestureBack) {
            self.interactivePopGestureRecognizer.enabled = NO;
        } else {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1 && [gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return NO;
    } else {
        return YES;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    
    return self.topViewController;
}


@end

//
//  FNFreshTarget_TabBarService.m
//  FNFresh
//
//  Created by JamesCorp on 2017/4/13.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNFreshTarget_TabBarService.h"
#import "FNFreshTabBarController.h"

@implementation FNFreshTarget_TabBarService
-(void)action_FNFreshTabBarController_SwitchTabBarWithParam:(id)param{
    NSString *tabItemIndex = [(NSDictionary*)param objectForKey:@"tabItemIndex"];
    if (tabItemIndex) {
        [[FNFreshTabBarController shareInstance] backToHomeViewAnimated:YES];
        [[FNFreshTabBarController shareInstance] switchTabBarWithParam:param];
    }
    
}
@end

//
//  FNMediator+FNUserCenterModule.h
//  ZZRouter
//
//  Created by litt1er on 17/4/26.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNMediator.h"
#import <UIKit/UIKit.h>

@interface FNMediator (FNUserCenterModule)

//本地组件调用 loginVC   外面的NavController我已经包过  直接present就行
- (UIViewController *)LoginModule_InitWithComplete:(void (^)())complete;

//本地组件调用 rigsterVC   外面的NavController我已经包过  直接present就行
- (UIViewController *)RegisterModule_Init;


@end

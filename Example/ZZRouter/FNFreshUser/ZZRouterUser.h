//
//  ZZRouterUser.h
//  ZZRouter
//
//  Created by litt1er on 17/3/16.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>



extern NSString * const kLoginSuccessNotification;
extern NSString * const kAddressChangedNotification;

@interface ZZRouterUser : NSObject


//是否登录
@property (nonatomic, assign) BOOL isLogin;










//保存门店相关信息
- (void)holdShopInfomationWithShoplongitude:(NSString *)longitude shoplatitude:(NSString *)latitude shopName:(NSString *)shopName shopAddr:(NSString *)shopAddr shopId:(NSString *)shopId;

//清除相关门店信息及地址信息
- (void)clearStoreInformationAndAddressInfomation;

+ (instancetype)shareInstance;


// 访问token相关
- (void)restoreToken;
- (void)requestDefaultToken;


// 用户信息
- (void)cleanUserInfo;



@end

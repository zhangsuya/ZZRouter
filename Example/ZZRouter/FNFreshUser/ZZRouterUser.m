//
//  ZZRouterUser.m
//  ZZRouter
//
//  Created by litt1er on 17/3/16.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterUser.h"




static NSString * const kAppToken                    = @"appToken";
static NSString * const kGaodeInformationDicKey      = @"gaodeInformationDicKey";
static NSString * const kShopInfomationDicKey        = @"shopInfomationDicKey";
static NSString * const kAddressKey                  = @"addressId";
static NSString * const kGuid                        = @"guid";
static NSString * const kPhone                       = @"phone";
static NSString * const kMail                        = @"mail";
static NSString * const kLastLoginNumber             = @"lastLoginNumber";
static NSString * const kLastLoginName               = @"lastLoginName";
static NSString * const kLastLoginType               = @"lastLoginType";
static NSString * const kIsNeedDisplay               = @"isNeedDisplay";
static NSString * const kIsLogin                     = @"FNYXIL";
static NSString * const kDeliveryAddress             = @"deliveryAddress";
static NSString * const kPresentCity                 = @"presentCity";
static NSString * const kSettingPayPassword          = @"FNYXIP";
static NSString * const kLongitude                   = @"isLongitude";
static NSString * const klatitude                    = @"isLatitude";
static NSString * const kDleiveryPoiName             = @"deliveryPoiName";

@interface ZZRouterUser ()

@property (nonatomic, copy, readwrite) NSString *userName;
@property (nonatomic, copy, readwrite) NSString *guid;
@property (nonatomic, copy, readwrite) NSString *phone;
@property (nonatomic, copy, readwrite) NSString *mail;
@property (nonatomic, assign) BOOL canRequest;

@end

@implementation ZZRouterUser

@synthesize isLogin                   = _isLogin;


#pragma mark - public methods
+ (instancetype)shareInstance
{
    static ZZRouterUser *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[ZZRouterUser alloc] init];
    });
    return _shareInstance;
}




#pragma mark - setter and getter

- (void)setIsSettingPayPassword:(BOOL)isSettingPayPassword
{
    [[NSUserDefaults standardUserDefaults] setObject:@(isSettingPayPassword) forKey:kSettingPayPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isSettingPayPassword
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kSettingPayPassword] boolValue];
}

- (void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setObject:@(isLogin) forKey:kIsLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLogin
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kIsLogin] boolValue];
}

- (void)setIsNeedDisplay:(BOOL)isNeedDisplay
{
    [[NSUserDefaults standardUserDefaults] setObject:@(isNeedDisplay) forKey:kIsNeedDisplay];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end

//
//  FNFreshUser.h
//  FNFresh
//
//  Created by litt1er on 17/3/16.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FNFreshLoginType) {
    
    FNFreshLoginTypePhoneVerificationLanding,       //手机验证登录
    FNFreshLoginTypeAccountPassword                 //账号密码登录
};

typedef NS_ENUM (NSUInteger, FNFreshLocationEnterType) {
    FNFreshEmptyType,
    FNFreshLocationType,
    FNFreshUserAddressType,
    FNFreshDefaultCityType
};

extern NSString * const kLoginSuccessNotification;
extern NSString * const kAddressChangedNotification;

@interface FNFreshUser : NSObject

//token
@property (nonatomic, copy) NSString *accessToken;
//用户名
@property (nonatomic, copy, readonly) NSString *userName;
//guid
@property (nonatomic, copy, readonly) NSString *guid;
//电话
@property (nonatomic, copy, readonly) NSString *phone;
//邮箱
@property (nonatomic, copy, readonly) NSString *mail;
//是否登录
@property (nonatomic, assign) BOOL isLogin;
//是否设置支付密码
@property (nonatomic, assign) BOOL isSettingPayPassword;
//上次登录方式
@property (nonatomic, assign) FNFreshLoginType lastLoginType;
//上次登录Name
@property (nonatomic, copy) NSString *lastLoginName;
//上次手机登录
@property (nonatomic, copy) NSString *lastLoginNumber;
//是否需要显示设置密码弹窗 我的账户用 其他地方勿用
@property (nonatomic, assign) BOOL isNeedDisplay;
//deviceTokenID
@property (nonatomic, copy, readonly) NSString *deviceToken;
//getuiClientID
@property (nonatomic, copy, readonly) NSString *getuiCID;

@property (nonatomic, copy) NSString *presentCity;


/**
 *  获取现在的areaCode
 */
@property (nonatomic, readonly)  NSString *areaCode;

/**
 *  获取现在的addressId
 */
@property (nonatomic, copy)      NSString *addressId;

/**
 *  进入app定位类型
 */
@property (nonatomic, assign) FNFreshLocationEnterType enterHomeType;

/**
 *  收货地址提醒，用于首页
 */
@property (nonatomic, copy)     NSString *addrWarn;

/**
 *  送至提示信息，用于首页
 */
@property (nonatomic, copy)     NSString *deliveryAddress;

//收货地址拼接字段
@property (nonatomic, copy)     NSString *deliveryPoiName;


/**
 *  容错推广页链接
 */
@property (nonatomic, copy)     NSString *pushH5LinkUrl;

/**
 *  定位error
 */
@property (nonatomic, strong)   NSError *locationError;


/**
 *  定位完成
 */
@property (nonatomic, assign)   BOOL  locationFinished;




/**
 *  高德地址缓存策略，通过gaodeDic获取经纬度以及地址信息、高德三级code
 */
@property (nonatomic, strong) NSDictionary *gaodeInformationDic;

@property (nonatomic, copy)   NSString *longitude;
@property (nonatomic, copy)   NSString *latitude;
@property (nonatomic, copy)   NSString *poiName;
@property (nonatomic, copy)   NSString *adcode;

//保存高德相关信息
/*高德三级code，高德经纬度，高德经纬度对应的地址信息*/
- (void)holdGaoDeInformationWithGaoDeCode:(NSString *)gaodeCode latitude:(NSString *)latitude longitude:(NSString *)longitude poiName:(NSString *)poiName;

@property (nonatomic, strong) NSDictionary *shopInfomationDic;

@property (nonatomic, copy)   NSString *shopLongitude;
@property (nonatomic, copy)   NSString *shopLatitude;
@property (nonatomic, copy)   NSString *shopName;
@property (nonatomic, copy)   NSString *shopAddr;
@property (nonatomic, copy)   NSString *shopId;

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

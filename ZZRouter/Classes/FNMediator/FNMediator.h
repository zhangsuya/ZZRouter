//
//  FNMediator.h
//  FNModuleDemo
//
//  Created by 张苏亚 on 16/11/23.
//  Copyright © 2016年 ZZRouter. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *Parameter_Body;
extern NSString *Parameter_Success;
extern NSString *Parameter_Failure;

@interface FNMediator : NSObject

+ (instancetype)sharedInstance;

/**
 远程App调用入口

 @param remoteURL 远程url
 @param completion 回调
 @return id类型
 */
- (id)performActionWithRemoteURL:(NSURL *)remoteURL completion:(void(^)(NSDictionary *info))completion;


/**
 新增参数的情况下远程App调用入口

 @param remoteURL 远程url
 @param params 字典参数
 @param completion 回调
 @return id类型
 */
- (id)performActionWithRemoteURL:(NSURL *)remoteURL withParams:(NSDictionary *)params completion:(void(^)(NSDictionary *info))completion;

/**
 本地组件调用入口

 @param nativeURL 本地url
 @param params 字典参数
 @param completion 回调
 @return id类型
 */
- (id)performActionWithNativeURL:(NSURL *)nativeURL withParams:(NSDictionary *)params completion:(void (^)(NSDictionary *))completion;

/**
 target action 入口

 @param targetName target名字
 @param actionName action名字
 @param params 字典参数
 @return id类型
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

/**
 返回字典

 @param paramsString paramsString description
 @return params字典
 */
- (NSDictionary *)paramsDictFromString:(NSString *)paramsString;


@end

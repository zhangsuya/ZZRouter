//
//  ZZRouter.h
//  FNFresh
//
//  Created by 张苏亚 on 17/3/24.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZZRouter : NSObject

/**
 远程App调用入口
 
 @param remoteURLString 远程urlString
 @param completion 回调
 */
- (void)jumpControllerWithRemoteURLString:(NSString *)remoteURLString completion:(void(^)(NSDictionary *info,NSError *error))completion;

/**
 h5跳native调用入口
 
 @param remoteURLString 远程url
 @param params block字典
 @param completion 回调
 */
- (void)jumpControllerWithRemoteURLString:(NSString *)remoteURLString params:(NSDictionary *)params completion:(void(^)(NSDictionary *info,NSError *error))completion;

@end

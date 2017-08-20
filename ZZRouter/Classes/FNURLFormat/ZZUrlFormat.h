//
//  ZZUrlFormat.h
//  FNModuleDemo
//
//  Created by 张苏亚 on 16/11/29.
//  Copyright © 2016年 ZZRouter. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ZZUrlFormatErrorDomain;

typedef NS_ENUM(NSInteger, ZZUrlFormatError) {
    UnexpectedRemoteScheme = -1000,//非法Scheme
    UnregistedModule //
};

extern NSString *const ZZRouterTypeErrorDomin;

typedef NS_ENUM(NSInteger, ZZRouterTypeError) {
     UnregistedRouterType = -1000,//未注册的routerType
    //
};


@interface ZZUrlFormat : NSObject

/**
 格式化远端url返回相应格式的nativeurl

 @param remoteUrl 远程url
 @param error 错误信息
 @return nativeUrl
 */
- (NSURL *)nativeUrlByFormatRemoteUrl:(NSURL *)remoteUrl error:(NSError **)error;

-(NSDictionary *)urlElementDictByRemoteUrl:(NSURL *)remoteUrl error:(NSError **)error;





@end

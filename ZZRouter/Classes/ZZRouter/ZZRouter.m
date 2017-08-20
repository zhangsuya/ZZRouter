//
//  ZZRouter.m
//  FNFresh
//
//  Created by 张苏亚 on 17/3/24.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouter.h"
#import "ZZUrlFormat.h"
#import "FNMediator.h"
#import "NSURL+Chinese.m"
#import "ZZRouterHelper.h"
#import "ZZRouterJumpTypeProtocol.h"
#import "ZZRouterRedirectProtocol.h"
#import "ZZRouterHelper.h"
#import "ZZRouterSequentialIndependenceProtocol.h"

//是否需要校验登陆
static const NSString *kRedirect = @"redirect";

static const NSString *kForward = @"forward";

//是否支持h5
static const NSString *kIsSupportH5 = @"isSupportH5";

//跳转方式
static const NSString *kJumpType = @"jumpType";

static const NSString *kSequentialIndependenceMethod = @"sequentialIndependenceMethod";

@interface ZZRouter ()
@property(nonatomic,copy) void (^h5Refresh)(NSString *url);
@end

@implementation ZZRouter

- (void)jumpControllerWithRemoteURLString:(NSString *)remoteURLString completion:(void(^)(NSDictionary *info,NSError *error))completion
{
    //链接
    NSURL *remoteURL = [NSURL urlWithChineseEnglishString:remoteURLString];
    
    
    //转换成nativeURL,nativeURL结构：nativefn://target/action?xxx
    ZZUrlFormat *urlFormat = [[ZZUrlFormat alloc] init];
    NSError *error;
    NSURL *nativeURL = [urlFormat nativeUrlByFormatRemoteUrl:remoteURL error:&error];
    if (error) {
        NSLog(@"error%@",error.userInfo);
        !completion ?: completion(nil,error);
        return;
    }
    //target,action必须都配进plist
    if ([nativeURL.host isKindOfClass:[NSNull class]] && [nativeURL.path isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *target_action = [NSString stringWithFormat:@"%@%@",nativeURL.host?:@"",nativeURL.path?:@""];
    if ([target_action isEqualToString:@""]) {
        return;
    }
    
    //根据原始url host，获取plist对应的元素结构
    NSDictionary *elementDict = [urlFormat urlElementDictByRemoteUrl:remoteURL error:&error];
    if (error) {
        completion(nil,error);
        return;
    }
    if ([elementDict objectForKey:kSequentialIndependenceMethod]) {
        NSObject<ZZRouterSequentialIndependenceProtocol> *sequentialIndependenceObject = [ZZRouterHelper sequentialIndependenceObjectByName:[elementDict objectForKey:kSequentialIndependenceMethod]];
        [sequentialIndependenceObject sequentialIndependenceMethod];
    }
    NSDictionary *h5Dict ;
    if ([[elementDict objectForKey:kIsSupportH5] boolValue]) {
        if (self.h5Refresh) {
            h5Dict= @{@"h5Refresh":self.h5Refresh};
        }
    }
    id returnValue = [[FNMediator sharedInstance] performActionWithNativeURL:nativeURL withParams:h5Dict completion:nil];
    
    NSObject<ZZRouterJumpTypeProtocol> *jumpTypeObject =[ZZRouterHelper jumpTypeObjectByName:[elementDict objectForKey:kJumpType] ];
    
    if ([elementDict objectForKey:kRedirect]) {
        NSObject<ZZRouterRedirectProtocol> *redirectObject = [ZZRouterHelper redirectObjectByName:[elementDict objectForKey:kRedirect]];
        [redirectObject redirectByOriginalVC:returnValue originalVCBlock:^(UIViewController *originalVC) {
            [jumpTypeObject jumpWithTypeVC:originalVC];
        }];
        
    }else if([elementDict objectForKey:kForward]){
        
        
    }else{
        [jumpTypeObject jumpWithTypeVC:returnValue];

    }

    
}

- (void)jumpControllerWithRemoteURLString:(NSString *)remoteURLString params:(NSDictionary *)params completion:(void(^)(NSDictionary *info,NSError *error))completion
{
    if ([params objectForKey:@"h5Refresh"]) {
        self.h5Refresh = [params objectForKey:@"h5Refresh"];
    }
    [self jumpControllerWithRemoteURLString:remoteURLString completion:^(NSDictionary *info, NSError *error) {
        if (completion) {
            completion(info,error);
        } 
    }];
}

@end

//
//  ZZUrlFormat.m
//  FNModuleDemo
//
//  Created by 张苏亚 on 16/11/29.
//  Copyright © 2016年 ZZRouter. All rights reserved.
//  www2fn/FeiniuMart/FNRTMart/playload/

#import "ZZUrlFormat.h"
#import "NSString+FNJSONCategories.h"

NSString *const ZZUrlFormatErrorDomain = @"ZZUrlFormatErrorDomain";
NSString *const ZZRouterTypeErrorDomin = @"ZZRouterTypeErrorDomin";

static NSString *const NATIVEURLSCHEME = @"nativeurl";


@implementation ZZUrlFormat

- (NSURL *)nativeUrlByFormatRemoteUrl:(NSURL *)remoteUrl error:(NSError **)error
{
    NSArray *remoteSchemeArray = [ZZUrlFormat remoteUrlSchemesArray];
    
    BOOL isExpectedScheme = NO;
    for (NSString *remoteSchemeName in remoteSchemeArray) {
        if ([remoteUrl.scheme isEqualToString:remoteSchemeName]) {
            isExpectedScheme = YES;
        }
    }
    
    if (!isExpectedScheme) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"传入了含有非法Scheme的url"                                                                      forKey:NSLocalizedDescriptionKey];

        *error = [NSError errorWithDomain:ZZUrlFormatErrorDomain code:UnexpectedRemoteScheme userInfo:userInfo];
        
        return nil;
    }
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = NATIVEURLSCHEME;
    
    //从plist中读取本地配置的内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UrlList" ofType:@"plist"];
    NSDictionary *urlDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //根据url host获取plist中的对应元素：host为对应的key
    NSString *url_host = [NSString stringWithFormat:@"%@",remoteUrl.host];
    NSDictionary *urlElementDict = urlDict[url_host];
    NSString *target_action = urlElementDict[@"nativeurl"];
    
    if (target_action == nil || [target_action isKindOfClass:[NSNull class]]) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"不存在与此远端url对应的native模块"                                                                      forKey:NSLocalizedDescriptionKey];
        
        *error = [NSError errorWithDomain:ZZUrlFormatErrorDomain code:UnregistedModule userInfo:userInfo];
        return nil;
    }
    
    //提取出plist元素中的target，action，作为新url的host，path
    NSArray *target_action_divide =  [target_action componentsSeparatedByString:@"/"];
    
    if (target_action_divide) {
        urlComponents.host = target_action_divide[0];
    }
    
    if (target_action_divide.count >=2) {
        if ([target_action containsString:@"?"]){
            NSString *tmpString = [target_action componentsSeparatedByString:@"/"][1];
            
            urlComponents.path =[NSString stringWithFormat:@"/%@",[tmpString componentsSeparatedByString:@"?"][0]] ;
        }else{
            urlComponents.path =[NSString stringWithFormat:@"/%@",target_action_divide[1]] ;
        }
    }
    
    urlComponents.query = [remoteUrl.query stringByRemovingPercentEncoding];

#ifdef DEBUG
    NSLog(@"scheme:%@ host:%@ path:%@ query:%@ queryItems:%@ fragment:%@",urlComponents.scheme,urlComponents.host,urlComponents.path,urlComponents.query,urlComponents.queryItems,urlComponents.fragment);
#endif
    return [urlComponents URLRelativeToURL:remoteUrl];
}

-(NSDictionary *)urlElementDictByRemoteUrl:(NSURL *)remoteUrl error:(NSError **)error
{
    NSArray *remoteSchemeArray = [ZZUrlFormat remoteUrlSchemesArray];
    BOOL isExpectedScheme = NO;
    for (NSString *remoteSchemeName in remoteSchemeArray) {
        if ([remoteUrl.scheme isEqualToString:remoteSchemeName]) {
            isExpectedScheme = YES;
        }
    }
    
    if (!isExpectedScheme) {
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"传入了含有非法Scheme的url"                                                                      forKey:NSLocalizedDescriptionKey];
        
        *error = [NSError errorWithDomain:ZZUrlFormatErrorDomain code:UnexpectedRemoteScheme userInfo:userInfo];
        
        return nil;
    }
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    
    urlComponents.scheme = NATIVEURLSCHEME;
    
    NSString *hostKeyString;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FNUrlList" ofType:@"plist"];
    NSDictionary *urlDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    
    hostKeyString = [NSString stringWithFormat:@"%@",remoteUrl.host];
    
    NSMutableDictionary *urlElementDict = [NSMutableDictionary dictionaryWithDictionary:urlDict[hostKeyString]];
    [urlElementDict removeObjectForKey:@"nativeurl"];
    return [urlElementDict copy];
}

+(NSArray *)remoteUrlSchemesArray
{
    NSMutableArray *remoteSchemeArray = @[].mutableCopy;
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSArray *bundleUrltypes = [infoDic objectForKey:@"CFBundleURLTypes"];
    
    for (NSDictionary *urlTypesDict in bundleUrltypes) {
        NSArray *urlSchemes = [urlTypesDict objectForKey:@"CFBundleURLSchemes"];
        [remoteSchemeArray addObjectsFromArray:urlSchemes];
    }
    return [remoteSchemeArray copy];
}

@end

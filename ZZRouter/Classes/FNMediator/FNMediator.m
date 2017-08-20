//
//  FNMediator.m
//  FNModuleDemo
//
//  Created by 张苏亚 on 16/11/23.
//  Copyright © 2016年 ZZRouter. All rights reserved.
//

#import "FNMediator.h"
#import "ZZUrlFormat.h"
#import "NSObject+Invocation.h"

NSString *Parameter_Body    = @"Parameter_Body";
NSString *Parameter_Success = @"Parameter_Success";
NSString *Parameter_Failure = @"Parameter_Failure";


@interface FNMediator ()

@property (nonatomic, copy) NSString *nativeScheme;
/**
 targetName的前置字符
 */
@property (nonatomic, copy) NSString *targetNamePrefix;
/**
 moduleTargetName的后置字符
 */
@property (nonatomic, copy) NSString *moduleTargetNameSuffix;
/**
 serviceTargetName的后置字符
 */
@property (nonatomic, copy) NSString *serviceTargetNameSuffix;
/**
 actionName的前置字符
 */
@property (nonatomic, copy) NSString *actionNamePrefix;

@end

@implementation FNMediator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static FNMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[FNMediator alloc] init];
    });
    return mediator;
}

- (instancetype)init
{
    if (self = [super init]) {
        _nativeScheme = @"nativefn";
        _targetNamePrefix = @"ZZRouterTarget";
        _moduleTargetNameSuffix = @"Module";
        _serviceTargetNameSuffix = @"Service";
        _actionNamePrefix = @"action";
    }
    return self;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params
{
    [self validateActionNameWithString:actionName];
    
    NSString *targetClassString = [NSString stringWithFormat:@"%@_%@", self.targetNamePrefix,targetName];
    Class targetClass = NSClassFromString(targetClassString);
    id target = [[targetClass alloc] init];
    NSString *actionString;
    SEL action;
    if (params ==nil) {
        actionString = [NSString stringWithFormat:@"%@_%@", self.actionNamePrefix,actionName];
        action = NSSelectorFromString(actionString);
        if (![target respondsToSelector:action]) {
            actionString = [actionString stringByAppendingString:@":"];
            action= NSSelectorFromString(actionString);
        }
    }else
    {
        actionString = [NSString stringWithFormat:@"%@_%@:", self.actionNamePrefix,actionName];
        action = NSSelectorFromString(actionString);
        if (![target respondsToSelector:action]) {
            actionString = [NSString stringWithFormat:@"%@_%@", self.actionNamePrefix,actionName];
            action = NSSelectorFromString(actionString);
        }
    }
    
    NSAssert(target!=nil, @"项目中不存在相应的target");
    id value = [target fn_performSelector:action withObject:params];
    if (value) {
        
        return value;
    } else {
        
        //处理找不到action的异常
        return nil;
    }
}

- (id)performActionWithNativeURL:(NSURL *)nativeURL withParams:(NSDictionary *)params completion:(void (^)(NSDictionary *))completion
{
    //如果有参数
    if (![nativeURL.scheme isEqualToString:self.nativeScheme]) {
        //对nativeScheme被篡改的处理
        return @(NO);
    }
    
    if (nativeURL.query != nil) {
        if (params == nil) {
            params = [self paramsDictFromString:[nativeURL.query stringByRemovingPercentEncoding]];
        } else {
            //相加
            NSMutableDictionary *sumDict = @{}.mutableCopy;
            [sumDict addEntriesFromDictionary:[self paramsDictFromString:[nativeURL.query stringByRemovingPercentEncoding]]];
            [sumDict addEntriesFromDictionary:params];
            
            params = [sumDict copy];
        }
    }

    return [self performTarget:[nativeURL host] action:nativeURL.pathComponents[1] params:params];
}

- (id)performActionWithRemoteURL:(NSURL *)remoteURL completion:(void(^)(NSDictionary *info))completion
{
    return [self performActionWithRemoteURL:remoteURL withParams:nil completion:completion];
}

- (id)performActionWithRemoteURL:(NSURL *)remoteURL withParams:(NSDictionary *)params completion:(void(^)(NSDictionary *info))completion
{
    ZZUrlFormat *urlFormat = [[ZZUrlFormat alloc] init];
    
    NSError *error = nil;
    
    NSURL *nativeURL =  [urlFormat nativeUrlByFormatRemoteUrl:remoteURL error:&error];
    
    if (error) {
        if (error.code == UnexpectedRemoteScheme) {
            //对非法Scheme的处理,跳到首页，并提醒用户?
        }else if (error.code == UnregistedModule)
        {
            //对远端url找不到对应的模块的处理
            NSAssert(false, @"请在FNUrlMapDataSource类的urlMapDict里添加上对应值");
        }
        return error;
    }
    return [self performActionWithNativeURL:nativeURL withParams:params completion:completion];
}

/**
 @param paramsString paramsString description
 @return params字典
 */
- (NSDictionary *)paramsDictFromString:(NSString *)paramsString
{
    if (paramsString == nil ||paramsString.length ==0) {
        return @{};
    }
    NSArray *keyValueArray = [paramsString componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *paramsDict = @{}.mutableCopy;
    
    for (NSString *keyValueString in keyValueArray) {
        NSArray *tmpArray = [keyValueString componentsSeparatedByString:@"="];
        if (tmpArray.count > 1) {
            NSString *keyString = [keyValueString componentsSeparatedByString:@"="][0];
            id value = [keyValueString componentsSeparatedByString:@"="][1];
            paramsDict[keyString]= value;
        }
        
    }
    return [paramsDict copy];
}

/**
 验证本地url的scheme是否正确，正确返回YES，错误返回NO

 @param urlString urlString description
 @return BOOL值YES代表nativeScheme开头
 */
- (BOOL)validateSchemeWithNativeUrlString:(NSString *)urlString
{
    if ([urlString hasPrefix:self.nativeScheme]) {
        return YES;
    }else
    {
        return NO;
    }
}

/**
 验证远程actionName后缀是否正确，错误直接崩溃

 @param actionNameString actionNameString description
 */
- (void)validateActionNameWithString:(NSString *)actionNameString
{
    NSString *actionVCName = [actionNameString componentsSeparatedByString:@"_"][0];
    
    Class vcClass = NSClassFromString(actionVCName);
    
    //id vc = [[vcClass alloc] init];
    //通常情况下actionName的前置字符串是个存在工程里的vc或者service的名字，也有一些例外情况，例外情况在此排除
    NSAssert(vcClass != nil, @"您的actionName不正确");
}

@end

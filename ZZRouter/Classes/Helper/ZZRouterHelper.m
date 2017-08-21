//
//  ZZRouterHelper.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/7/18.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterHelper.h"
#import "ZZRouterJumpTypeFactoryProtocol.h"

@interface ZZRouterHelper()
{
    NSMutableDictionary *_routerMethodDict;
    NSMutableDictionary *_urlListDict;
}
@property (nonatomic, strong) Class<ZZRouterJumpTypeFactoryProtocol> jumpTypeFactoryClass;
@property (nonatomic, strong) Class<ZZRouterRedirectFactoryProtocol> redirectFactoryClass;
@property (nonatomic, strong) Class<ZZRouterSequentialIndependenceFactoryProtocol> sequentialIndependenceFactoryClass;


@property (nonatomic, strong) NSArray *remoteUrlScheme;
@end

@implementation ZZRouterHelper

+ (ZZRouterHelper*)sharedInstance
{
    static ZZRouterHelper *_dataSourceHelper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _dataSourceHelper = [[ZZRouterHelper alloc] init];
    });
    return _dataSourceHelper;
}

-(NSMutableDictionary *)routerMethodDict
{
    if (!_routerMethodDict) {
        _routerMethodDict = @{}.mutableCopy;
    }
    return _routerMethodDict;
}

-(NSMutableDictionary *)urlListDict
{
    if (!_urlListDict) {
        _urlListDict =@{}.mutableCopy;
    }
    return _urlListDict;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.jumpTypeFactoryClass = NSClassFromString(@"ZZRouterJumpTypeFactory");
        self.redirectFactoryClass = NSClassFromString(@"ZZRouterRedirectFactory");
        self.sequentialIndependenceFactoryClass = NSClassFromString(@"ZZRouterSequentialIndependenceFactory");
        NSString *elementMapPath= [[NSBundle mainBundle] pathForResource:@"RouterMethod" ofType:@"plist"];
        if (elementMapPath!=nil) {
            [self.routerMethodDict addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:elementMapPath]]  ;

        }
        NSString *urlMapPath= [[NSBundle mainBundle] pathForResource:@"UrlList" ofType:@"plist"];
        if (urlMapPath!=nil) {
            [self.urlListDict addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:urlMapPath]]  ;
            
        }
  
    }
    return self;
}

+ (void)registMethodListName:(NSString *)methodListName urlListName:(NSString *)urlListName
{
    if (methodListName) {
        NSString *elementMapPath= [[NSBundle mainBundle] pathForResource:methodListName ofType:@"plist"];
        [[ZZRouterHelper sharedInstance].routerMethodDict addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:elementMapPath]] ;
    }
    
    if (urlListName) {
        NSString *urlListPath = [[NSBundle mainBundle] pathForResource:urlListName ofType:@"plist"];
        [[ZZRouterHelper sharedInstance].urlListDict addEntriesFromDictionary: [NSDictionary dictionaryWithContentsOfFile:urlListPath]] ;
    }
    
}

+ (void)registRouterFactoryClassName:(NSString *)jumpTypeFactoryClassName
{
    if ([NSClassFromString(jumpTypeFactoryClassName) instanceMethodForSelector:@selector(jumpTypeObjectByName:)]) {
        [ZZRouterHelper sharedInstance].jumpTypeFactoryClass = NSClassFromString(jumpTypeFactoryClassName);
    }
}

+ (void)registRedirectFactoryClassName:(NSString *)redirectFactoryClassName
{
    if ([NSClassFromString(redirectFactoryClassName) instanceMethodForSelector:@selector(redirectObjectByName:)]) {
        [ZZRouterHelper sharedInstance].redirectFactoryClass = NSClassFromString(redirectFactoryClassName);
    }
}

+ (void)registForwardFactoryClassName:(NSString *)sequentialIndependenceFactoryClassName
{
    if ([NSClassFromString(sequentialIndependenceFactoryClassName) instanceMethodForSelector:@selector(redirectObjectByName:)]) {
        [ZZRouterHelper sharedInstance].sequentialIndependenceFactoryClass = NSClassFromString(sequentialIndependenceFactoryClassName);
    }
}


+(NSObject<ZZRouterJumpTypeProtocol> *)jumpTypeObjectByName:(NSString *)typeName
{
    NSDictionary *jumpTypeDict = [[ZZRouterHelper sharedInstance].routerMethodDict objectForKey:@"jumpType"];
    return [[ZZRouterHelper sharedInstance].jumpTypeFactoryClass jumpTypeObjectByName:[jumpTypeDict objectForKey:typeName]];
}

+(NSObject<ZZRouterRedirectProtocol> *)redirectObjectByName:(NSString *)redirectName
{
    NSDictionary *redirectDict = [[ZZRouterHelper sharedInstance].routerMethodDict objectForKey:@"redirect"];
    return [[ZZRouterHelper sharedInstance].redirectFactoryClass redirectObjectByName:[redirectDict objectForKey:redirectName]];
}

+(NSObject<ZZRouterSequentialIndependenceProtocol> *)sequentialIndependenceObjectByName:(NSString *)sequentialIndependenceName
{
    NSDictionary *forwardDict =[[ZZRouterHelper sharedInstance].routerMethodDict objectForKey:@"sequentialIndependenceMethod"];
    return [[ZZRouterHelper sharedInstance].sequentialIndependenceFactoryClass sequentialIndependenceObjectByName:[forwardDict objectForKey:sequentialIndependenceName]];
}


@end

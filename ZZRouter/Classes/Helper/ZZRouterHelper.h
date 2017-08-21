//
//  ZZRouterHelper.h
//  ZZRouter
//
//  Created by 张苏亚 on 17/7/18.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZRouterJumpTypeProtocol.h"
#import "ZZRouterRedirectFactory.h"
#import "ZZRouterSequentialIndependenceFactoryProtocol.h"

@interface ZZRouterHelper : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *routerMethodDict;

@property (nonatomic, strong, readonly) NSMutableDictionary *urlListDict;

+ (ZZRouterHelper*)sharedInstance;
+ (void)registRouterFactoryClassName:(NSString *)routerFactoryClassName;
+ (void)registRedirectFactoryClassName:(NSString *)redirectFactoryClassName;
+ (void)registForwardFactoryClassName:(NSString *)forwardFactoryClassName;
+ (void)registMethodListName:(NSString *)methodListName urlListName:(NSString *)urlListName;

+(NSObject<ZZRouterJumpTypeProtocol> *)jumpTypeObjectByName:(NSString *)typeName;
+(NSObject<ZZRouterRedirectProtocol> *)redirectObjectByName:(NSString *)redirectName;
+(NSObject<ZZRouterSequentialIndependenceProtocol> *)sequentialIndependenceObjectByName:(NSString *)sequentialIndependenceName;

@end

//
//  ZZRouterJumpTypeFactory.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/7/18.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "ZZRouterJumpTypeFactory.h"
#import <objc/runtime.h>

@interface ZZRouterJumpTypeFactory ()

@property (nonatomic, strong) NSMutableArray<NSString *> *elementForbiddenPropertyArray;

@end

@implementation ZZRouterJumpTypeFactory

+ (ZZRouterJumpTypeFactory*)sharedInstance
{
    static ZZRouterJumpTypeFactory *_elementFactory= nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _elementFactory = [[ZZRouterJumpTypeFactory alloc] init];
    });
    return _elementFactory;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.elementForbiddenPropertyArray = [[NSMutableArray alloc]init];
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList([UIView class], &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            // Get property name (C String)
            const char *cName = property_getName(property);
            // Transfer to objective-c string
            NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
            [self.elementForbiddenPropertyArray addObject:name];
        }
        NSArray *otherForbiddenArray = @[@"jumpType",@"nativeURL",@"isSupportH5"];
        [self.elementForbiddenPropertyArray addObjectsFromArray:otherForbiddenArray];
        
    }
    return self;
}


+(NSObject<ZZRouterJumpTypeProtocol> *)jumpTypeObjectByName:(NSString *)typeName
{
    NSObject<ZZRouterJumpTypeProtocol> *jumpTypeObject = (NSObject<ZZRouterJumpTypeProtocol> *)[[NSClassFromString(typeName) alloc]init];
    return jumpTypeObject;
}

//+(UIViewController *)redirectVCByModel:(NSObject<ZZRouterJudgeVCModelProtocol> *)model
//{
//    
//}

@end

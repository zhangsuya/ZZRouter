//
//  UIColor+FNColor.m
//  FNMarket
//
//  Created by fuyong on 16/4/5.
//  Copyright © 2016年 ZZRouter. All rights reserved.
//

#import "UIColor+FNColor.h"
#import "NSBundle+FNColor.h"
#import "BFKit.h"


/**
 *  This category adds some useful methods to NSDictionary
 */
@interface NSDictionary (FNColor)

/**
 *  Returns an object if key exists or nil if not
 *
 *  @param key Key to get value of
 *
 *  @return Value for the key Or nil
 */
- (id _Nullable)fnColor_safeObjectForKey:(NSString * _Nonnull)key;

@end


@implementation NSDictionary (FNColor)

- (id _Nullable)fnColor_safeObjectForKey:(NSString * _Nonnull )key {
    NSArray *keysArray = [self allKeys];
    if ([keysArray containsObject:key]) {
        return [self objectForKey:key];
    } else {
        return nil;
    }
}

@end


@implementation UIColor (FNColor)

+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey
{
    NSAssert(colorKey, @"colorKey为空");
    NSDictionary *colorDict = [self fn_ColorDictionary];
    return [self fn_ColorWithColorKey:colorKey colorDict:colorDict];
}

+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey alpha:(CGFloat)alpha
{
    UIColor *color = [self fn_colorWithColorKey:colorKey];
    return [UIColor colorWithColor:color alpha:alpha];
}

+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey colorSubjectKey:(NSString *)subjectKey
{
    NSAssert(subjectKey, @"subjectKey为空");
    NSMutableDictionary *mapDict = [self fn_MapColorDictionary];
    NSDictionary *colorDict = [mapDict fnColor_safeObjectForKey:subjectKey];
    
    if (!colorDict) {
        NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:subjectKey ofType:@"plist"];
        NSAssert(fontFilePath, @"找不到对应的主题plist文件");
        colorDict = [NSDictionary dictionaryWithContentsOfFile:fontFilePath];
        [mapDict setObject:colorDict forKey:subjectKey];
    }
    return [self fn_ColorWithColorKey:colorKey colorDict:colorDict];
}

+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey colorSubjectKey:(NSString *)subjectKey alpha:(CGFloat)alpha
{
    UIColor *color = [self fn_colorWithColorKey:colorKey colorSubjectKey:subjectKey];
    return [UIColor colorWithColor:color alpha:alpha];
}

#pragma mark private api

+ (UIColor *)fn_ColorWithColorKey:(NSString *)colorKey colorDict:(NSDictionary *)colorDict {
    
    NSAssert(colorKey, @"输入的colorKey，找不到对应的字体值");
    NSString *colorString = [colorDict fnColor_safeObjectForKey:colorKey];
    NSAssert(colorString, @"输入的colorKey，找不到对应的颜色值");
    
    return [UIColor hex:colorString];
}

+ (NSDictionary *)fn_ColorDictionary {
    
    static dispatch_once_t token;
    static NSMutableDictionary *tmpDict;
    
    dispatch_once(&token, ^{
        
        NSDictionary *mainBundleColorDict;
        NSDictionary *fnColorBundleDict;
        
        //从mainBundle加载plist
        NSString *mainBundleColorPath = [[NSBundle mainBundle] pathForResource:@"FNColor_main" ofType:@"plist"];
        //从FNFont.bundle加载默认字体plist
        NSString *fnColorBundlePath = [[NSBundle fn_ColorBundle] pathForResource:@"FNColor_main" ofType:@"plist"];
//        NSAssert(fnColorBundlePath, @"FNFont_main.plist文件缺失");
        
        if (mainBundleColorPath) {
            //加载mainBundle的plist
            mainBundleColorDict = [NSDictionary dictionaryWithContentsOfFile:mainBundleColorPath];
        }
        
        fnColorBundleDict = [NSDictionary dictionaryWithContentsOfFile:fnColorBundlePath];
        tmpDict = [NSMutableDictionary dictionaryWithDictionary:fnColorBundleDict];
        
        //遍历mainbundle的字典，更新字典value
        for (NSString *key in mainBundleColorDict) {
            [tmpDict setObject:[mainBundleColorDict fnColor_safeObjectForKey:key] forKey:key];
        }
        
    });
    
    return tmpDict;
}



+ (NSMutableDictionary *)fn_MapColorDictionary {
    
    static NSMutableDictionary *fn_MapColorDictionary;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        fn_MapColorDictionary = [NSMutableDictionary dictionary];
    });
    
    return fn_MapColorDictionary;
    
}






@end

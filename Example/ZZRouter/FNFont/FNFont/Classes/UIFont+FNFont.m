//
//  UIFont+FNFont.m
//  Pods
//
//  Created by Minyoung  on 17/2/27.
//
//

#import "UIFont+FNFont.h"
#import "NSBundle+FNFont.h"

#pragma mark - NSDictionary extension

/**
 *  This category adds some useful methods to NSDictionary
 */
@interface NSDictionary (FNFont)

/**
 *  Returns an object if key exists or nil if not
 *
 *  @param key Key to get value of
 *
 *  @return Value for the key Or nil
 */
- (id _Nullable)fnFont_safeObjectForKey:(NSString * _Nonnull)key;

@end


@implementation NSDictionary (FNFont)

- (id _Nullable)fnFont_safeObjectForKey:(NSString * _Nonnull )key {
    NSArray *keysArray = [self allKeys];
    if ([keysArray containsObject:key]) {
        return [self objectForKey:key];
    } else {
        return nil;
    }
}

@end

#pragma mark - UIFont extension

@implementation UIFont (FNFont)

+ (UIFont *)fn_FontWithFontKey:(NSString *)fontKey {
    
    NSDictionary *dict = [self fn_FontDictionary];
    return [self fn_FontWithFontKey:fontKey fontDict:dict bold:NO];
}

+ (UIFont *)fn_BoldFontWithFontKey:(NSString *)fontKey {
    NSDictionary *dict = [self fn_FontDictionary];
    return [self fn_FontWithFontKey:fontKey fontDict:dict bold:YES];
}


+ (UIFont *)fn_FontWithFontKey:(NSString *)fontKey fontSubjectKey:(NSString *)subjectKey bold:(BOOL)bold {
    
    NSAssert(subjectKey, @"subjectKey为空");
    
    NSMutableDictionary *mapDict = [self fn_MapFontDictionary];
    NSDictionary *fontDict = [mapDict fnFont_safeObjectForKey:subjectKey];
    
    if ([subjectKey isEqualToString:@"FNFont_Main"]) {
        return [self fn_FontWithFontKey:fontKey];
    }
    
    if (!fontDict) {
        NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:subjectKey ofType:@"plist"];
        NSAssert(fontFilePath, @"找不到对应的主题plist文件");
        fontDict = [NSDictionary dictionaryWithContentsOfFile:fontFilePath];
        [mapDict setObject:fontDict forKey:subjectKey];
    }
    
    return [self fn_FontWithFontKey:fontKey fontDict:fontDict bold:bold];
}

#pragma mark private api

+ (UIFont *)fn_FontWithFontKey:(NSString *)fontKey fontDict:(NSDictionary *)fontDict bold:(BOOL)bold {
    
    NSAssert(fontKey, @"输入的fontKey，找不到对应的字体值");
    NSNumber *fontPxNumber = [fontDict fnFont_safeObjectForKey:fontKey];
    NSAssert(fontPxNumber, @"输入的fontKey，找不到对应的字体值");
    CGFloat fontSize = fontPxNumber.integerValue * 0.5;
    
    if (bold) {
        return [UIFont boldSystemFontOfSize:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
    
}

+ (NSDictionary *)fn_FontDictionary {
    
    static dispatch_once_t token;
    static NSMutableDictionary *tmpDict;
    
    dispatch_once(&token, ^{
        
        NSDictionary *mainBundleFontDict;
        NSDictionary *fnFontBundleDict;
        
        //从mainBundle加载plist
        NSString *mainBundleFontPath = [[NSBundle mainBundle] pathForResource:@"FNFont_Main" ofType:@"plist"];
        //从FNFont.bundle加载默认字体plist
        NSString *fnFontBundlePath = [[NSBundle fn_FontBundle] pathForResource:@"FNFont_Main" ofType:@"plist"];
//        NSAssert(fnFontBundlePath, @"FNFont_Main.plist文件缺失");
        
        if (mainBundleFontPath) {
            //加载mainBundle的plist
            mainBundleFontDict = [NSDictionary dictionaryWithContentsOfFile:mainBundleFontPath];
        }
        
        fnFontBundleDict = [NSDictionary dictionaryWithContentsOfFile:fnFontBundlePath];
        tmpDict = [NSMutableDictionary dictionaryWithDictionary:fnFontBundleDict];
        
        //遍历mainbundle的字典，更新字典value
        for (NSString *key in mainBundleFontDict) {
            [tmpDict setObject:[mainBundleFontDict fnFont_safeObjectForKey:key] forKey:key];
        }
        
    });
    
    return tmpDict;
}


/**
 mapDict 存放的<subjectKey:fontDict>
 
 @return <#return value description#>
 */
+ (NSMutableDictionary *)fn_MapFontDictionary {
    
    static NSMutableDictionary *fn_MapFontDictionary;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        fn_MapFontDictionary = [NSMutableDictionary dictionary];
    });
    
    return fn_MapFontDictionary;
    
}

@end

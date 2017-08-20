//
//  NSURL+Chinese.m
//  ZZRouter
//
//  Created by 张苏亚 on 17/3/31.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "NSURL+Chinese.h"
#import <UIKit/UIKit.h>

@implementation NSURL (Chinese)

+(NSURL *)urlWithChineseEnglishString:(NSString *)urlString
{
    if ([urlString includeChinese]) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0) {
            NSString *encodingString= [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            return [NSURL URLWithString:encodingString];
            
        }else
        {
            NSString *encodingString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            return [NSURL URLWithString:encodingString];
        }
    }else
    {
        return [NSURL URLWithString:urlString];
    }
}

@end

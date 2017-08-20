//
//  NSString+FNJSONCategories.m
//  FNMarket
//
//  Created by 张苏亚 on 17/2/17.
//  Copyright © 2017年 ZZRouter. All rights reserved.
//

#import "NSString+FNJSONCategories.h"

@implementation NSString (FNJSONCategories)

-(id)JSONValue
{
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil) return nil;
    
    return result;
    
}

@end

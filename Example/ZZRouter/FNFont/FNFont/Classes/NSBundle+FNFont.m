//
//  NSBundle+FNFont.m
//  Pods
//
//  Created by Minyoung  on 17/2/27.
//
//

#import "NSBundle+FNFont.h"

@implementation NSBundle (FNFont)

+ (NSBundle *)fn_FontBundle {
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSURL *bundleUrl = [bundle URLForResource:@"FNFont" withExtension:@"bundle"];
    
    NSBundle *resourceBundle;
    if(bundleUrl!=nil)
    {
        resourceBundle = [NSBundle bundleWithURL:bundleUrl];
    }
    return resourceBundle;
}
@end

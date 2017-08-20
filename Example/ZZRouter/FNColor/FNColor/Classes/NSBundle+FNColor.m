//
//  NSBundle+FNFont.m
//  Pods
//
//  Created by Minyoung  on 17/2/27.
//
//

#import "NSBundle+FNColor.h"

@implementation NSBundle (FNColor)

+ (NSBundle *)fn_ColorBundle {
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSURL *bundleUrl = [bundle URLForResource:@"FNColor" withExtension:@"bundle"];
    
    NSBundle *resourceBundle;
    
    if (bundleUrl) {
        resourceBundle = [NSBundle bundleWithURL:bundleUrl];
    }
    
    return resourceBundle;
}
@end

//
//  UIFont+FNFont.h
//  Pods
//
//  Created by Minyoung  on 17/2/27.
//
//

#import <UIKit/UIKit.h>

static NSString * const kFC_A = @"fc_A";

static NSString * const kFC_B = @"fc_B";

static NSString * const kFC_C = @"fc_C";

static NSString * const kFC_D = @"fc_D";

static NSString * const kFC_E = @"fc_E";

/**
 feiniu Font
 
 @note default main subject font  has five key:"fc_A",@"fc_B","fc_C","fc_D","fc_E"
 
 */
@interface UIFont (FNFont)

/**
 默认加载字体(从"FNFont_Main.plist"获取对应值)
 
 @param fontKey 字体key,such "fc_A",@"fc_B","fc_C","fc_D","fc_E"
 
 @return UIFont
 */
+ (UIFont *)fn_FontWithFontKey:(NSString *)fontKey;

/**
 默认加载加粗字体(从"FNFont_Main.plist"获取对应值)
 
 @param fontKey 字体key,such "fc_A",@"fc_B","fc_C","fc_D","fc_E"
 
 @return UIFont
 */
+ (UIFont *)fn_BoldFontWithFontKey:(NSString *)fontKey;


/**
 从自定义主题加载字体
 
 @param fontKey    字体key such "fc_A",@"fc_B","fc_C","fc_D","fc_E"
 @param subjectKey 自定义主题key
 @param bold       是否加粗
 
 @discuss  subjectKey 实际是自定义主题的plist文件名称，mainBundle
 
 @return UIFont
 */
+ (UIFont *)fn_FontWithFontKey:(NSString *)fontKey fontSubjectKey:(NSString *)subjectKey bold:(BOOL)bold;



@end

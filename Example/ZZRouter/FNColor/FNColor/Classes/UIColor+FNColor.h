//
//  UIColor+FNColor.h
//  FNMarket
//
//  Created by fuyong on 16/4/5.
//  Copyright © 2016年 cn.com.feiniu. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString * const FNColor_Blue =   @"blue";

static NSString * const FNColor_Super_Light_Grey = @"super_light_grey";

static NSString * const FNColor_White = @"white";

static NSString * const FNColor_Background_Color = @"background_color";

static NSString * const FNColor_Main_Color = @"main_color";

static NSString * const FNColor_Black  = @"black";

static NSString * const FNColor_Medium_Grey = @"medium_grey";

static NSString * const FNColor_Light_Grey = @"light_grey";

static NSString * const FNColor_Dark_Grey = @"dark_grey";

static NSString * const FNColor_Light_Yellow = @"light_yellow";

static NSString * const FNColor_Line = @"line";

static NSString * const FNColor_Button_Grey = @"button_grey";

static NSString * const FNColor_Logo_Color = @"logo_color";

static NSString * const FNColor_Deep_Red = @"deep_red";

static NSString * const FNColor_Orange = @"orange";

static NSString * const FNColor_Navigation = @"navigation";

static NSString * const FNColor_Mall_Card = @"mall_card";

static NSString * const FNColor_Cyanoze = @"cyanoze";

static NSString * const FNColor_Price_Color = @"price_color";

static NSString * const FNColor_Control_Color = @"control_color";

static NSString * const FNColor_HPink = @"h-pink";

static NSString * const FNColor_Module_Line = @"module_line";

static NSString * const FNColor_Deep_Purple = @"deep_purple";

static NSString * const FNColor_Pink = @"pink";

static NSString * const FNColor_Global_Card = @"global_card";

static NSString * const FNColor_Cuecolor = @"cuecolor";

static NSString * const FNColor_Self_Card = @"self_card";


@interface UIColor (FNColor)

/**
 默认加载字体(从"FNFont_main.plist"获取对应值)
 @param colorKey such:
 "FNColor_Blue",
 "FNColor_Super_Light_Grey",
 "FNColor_White",
 "FNColor_Background_Color",
 "FNColor_Main_Color",
 "FNColor_Black",
 "FNColor_Medium_Grey",
 "FNColor_Light_Grey",
 "FNColor_Dark_Grey",
 "FNColor_Light_Yellow",
 "FNColor_Line",
 "FNColor_Button_Grey"
 */

+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey;


+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey alpha:(CGFloat)alpha;

/**
 从自定义主题加载颜色值
 
 @param colorKey    字体key such 
 "FNColor_Blue",
 "FNColor_Super_Light_Grey",
 "FNColor_White",
 "FNColor_Background_Color",
 "FNColor_Main_Color",
 "FNColor_Black",
 "FNColor_Medium_Grey",
 "FNColor_Light_Grey",
 "FNColor_Dark_Grey",
 "FNColor_Light_Yellow",
 "FNColor_Line",
 "FNColor_Button_Grey"
 @param subjectKey 自定义主题key
 
 @discuss  subjectKey 实际是自定义主题的plist文件名称，mainBundle
 
 @return UIColor
 */

+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey colorSubjectKey:(NSString *)subjectKey;

+ (UIColor *)fn_colorWithColorKey:(NSString *)colorKey colorSubjectKey:(NSString *)subjectKey alpha:(CGFloat)alpha;


@end

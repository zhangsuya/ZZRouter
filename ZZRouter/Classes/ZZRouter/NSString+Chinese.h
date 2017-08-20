//
//  NSString+Chinese.h
//  ZZRouter
//
//  Created by 张苏亚 on 17/3/29.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Chinese)

/**
 是否汉字

 @return bool类型
 */
- (BOOL)isChinese;

/**
 是否包含汉字

 @return bool类型
 */
- (BOOL)includeChinese;

@end

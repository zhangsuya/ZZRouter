//
//  ZZRouterJumpTypeProtocol.h
//  ZZRouter
//
//  Created by 张苏亚 on 17/5/22.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZZRouterJumpTypeProtocol <NSObject>



-(void)jumpWithTypeVC:(UIViewController *)typeVC paramsDict:(NSDictionary *)params;




@end

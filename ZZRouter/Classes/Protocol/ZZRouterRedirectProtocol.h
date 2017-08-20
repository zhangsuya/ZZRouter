//
//  ZZRouterRedirectProtocol.h
//  FNFresh
//
//  Created by 张苏亚 on 17/8/2.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^OriginalVCJumpAction)(UIViewController *originalVC);

@protocol ZZRouterRedirectProtocol <NSObject>

-(void)redirectByOriginalVC:(UIViewController *)originalVC originalVCBlock:(OriginalVCJumpAction)jumpAction;

@end

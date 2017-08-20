//
//  ZZRouterForwardProtocol.h
//  ZZRouter
//
//  Created by 张苏亚 on 17/8/2.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZRouterForwardProtocol <NSObject>

-(NSURL *)forwardURL:(NSURL *)remoterUrl;

@end

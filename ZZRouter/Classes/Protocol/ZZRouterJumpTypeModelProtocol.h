//
//  ZZRouterJumpTypeProtocol.h
//  FNFresh
//
//  Created by 张苏亚 on 17/7/18.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZZRouterJumpTypeModelProtocol <NSObject>

@property (nonatomic,copy) NSString *jumpType;

@property (nonatomic,strong) UIViewController *vc;

@end

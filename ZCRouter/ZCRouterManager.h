//
//  ZCRouterManager.h
//  NightLove
//
//  Created by zengchao on 2019/3/27.
//  Copyright © 2019 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCRouterManager : NSObject

+ (void)registerRouter;

+ (void)addRouteByPattern:(NSString *)pattern;

@end

NS_ASSUME_NONNULL_END

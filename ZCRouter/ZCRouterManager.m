//
//  ZCRouterManager.m
//  NightLove
//
//  Created by zengchao on 2019/3/27.
//  Copyright © 2019 zengchao. All rights reserved.
//

#import "ZCRouterManager.h"
#import "ZCRouter.h"

@implementation ZCRouterManager

+ (void)registerRouter {
    
    [self addHttpRouter];
    [self addHttpsRouter];
    [self addRouteByPattern:@"vc:/"];
    [self addRouteByPattern:@"vc:/type:/"];
    [self addRouteByPattern:@"vc:/type:/animation:/"];
}

+ (void)addHttpRouter {
    
    [ZCRouter addRouterByScheme:ZCHTTPRouteSchema handler:^(NSDictionary * _Nonnull params, void (^callback)(id params)) {
        
        
    }];
}

+ (void)addHttpsRouter {
    
    [ZCRouter addRouterByScheme:ZCHTTPsRouteSchema handler:^(NSDictionary * _Nonnull params, void (^callback)(id params)) {
        
        
    }];
}

+ (void)addRouteByPattern:(NSString *)pattern {
    
    [ZCRouter addRouterByPattern:pattern handler:^(NSDictionary * _Nonnull params, void (^callback)(id params)) {
       
        NSLog(@"%@", params);
    }];
}





@end

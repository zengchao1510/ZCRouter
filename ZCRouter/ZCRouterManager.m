//
//  ZCRouterManager.m
//  NightLove
//
//  Created by zengchao on 2019/3/27.
//  Copyright © 2019 zengchao. All rights reserved.
//

#import "ZCRouterManager.h"
#import "ZCRouter.h"
#import "ZCRouterConstant.h"

@implementation ZCRouterManager

+ (void)registerRouter {
    
    [self registerHttpRouter];
    [self registerHttpsRouter];
    [self addRouteByPattern:@"vc:/type:/animation:/"];
}

+ (void)registerHttpRouter {
    
    [ZCRouter addRouterByScheme:ZCHTTPRouteSchema handler:^(NSDictionary * _Nonnull params, void (^callback)(id params)) {
        
        
    }];
}

+ (void)registerHttpsRouter {
    
    [ZCRouter addRouterByScheme:ZCHTTPsRouteSchema handler:^(NSDictionary * _Nonnull params, void (^callback)(id params)) {
        
        
    }];
}

+ (void)registerRouterByScheme:(NSString *)scheme {
    
    
}

// 使用默认的scheme， pattern形式：vc:/type:/aninmation:/
+ (void)addRouteByPattern:(NSString *)pattern {
    
    [ZCRouter addRouterByPattern:pattern handler:^(NSDictionary * _Nonnull params, void (^ callback)(id params)) {
       
        NSLog(@"%@", params);
    }];
}


//+ (void)parseParams:(NSDictionary *)params
//           callback:(void (^)(id params))callback {
//
//    NSDictionary *pathComponent = params[@"pathComponent"];
//    NSDictionary *queryMap      = params[@"query"];
//    NSDictionary *additionalMap = params[@"params"];
//
//    NSString *name = pathComponent[@"name"];
//    NSString *type = pathComponent[@"type"];
//    NSString *animation = pathComponent[@"animation"];
//
//    NSDictionary *localRouterParams = [ZCFileManager getRouterParams];
//    NSDictionary *routerParam       = [localRouterParams objectForKey:name];
//    NSString *className             = [routerParam objectForKey:@"name"];
//    NSInteger hiddenNavigationBar   = [[routerParam objectForKey:@"hiddenNavigationBar"] integerValue];
//    if (!type) {
//
//        type = [routerParam objectForKey:@"type"];
//    }
//
//    Class Cls = NSClassFromString(className);
//    if (!Cls) {
//
//        NSAssert(Cls, @"该类不存在");
//        return;
//    }
//
//    NSString *title = [routerParam objectForKey:@"title"];
//    UIViewController *vc = [[Cls alloc] init];
//    if (hiddenNavigationBar == 1) {
//
//        [vc setValue:@"0" forKey:@"navBarAlpha"];
//    } else {
//
//        [vc setValue:@"1" forKey:@"navBarAlpha"];
//    }
//
//    if (additionalMap && [additionalMap count] > 0) {
//
//        [additionalMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//            [vc setValue:obj forKey:key];
//        }];
//    }
//
//    if (callback) {
//
////        [vc setCallback:callback];
//    }
//
//    if ([type isEqualToString:@"push"]) {
//
//        if (queryMap && [queryMap count] > 0) {
//
//            [queryMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
////                [vc setObjectForKey:key value:obj];
//            }];
//        }
////        [ZCNavigatorManager pushViewController:vc animated:YES finishBlock:nil];
//    } else if ([type isEqualToString:@"present"]) {
//
//        if ([animation isEqualToString:@"1"]) {
//
////            [ZCNavigatorManager presentViewController:vc type: ANIMATION_TYPE_FRAME];
//        } else if ([animation isEqualToString:@"2"]) {
//
////            [ZCNavigatorManager presentViewController:vc type: ANIMATION_TYPE_CIRCLE];
//        } else if ([animation isEqualToString:@"3"]) {
//
//            NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
//            if (queryMap) {
//
//                [muDic setValuesForKeysWithDictionary:queryMap];
//            }
//            if (additionalMap) {
//
//                [muDic setValuesForKeysWithDictionary:additionalMap];
//            }
////            [ZCNavigatorManager presentViewController:vc type: ANIMATION_TYPE_APPSTORE params:muDic.copy];
//        }
//    } else if ([type isEqualToString:@"root"]) {
//
////        [ZCNavigatorManager setRootViewController:vc];
//    }
//}

@end

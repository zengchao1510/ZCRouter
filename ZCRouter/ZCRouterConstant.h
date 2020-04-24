//
//  ZCRouterConstant.h
//  LiaoBa-Man
//
//  Created by zengchao on 2020/4/20.
//  Copyright © 2020 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 路由模式

/**
 模式 Native：AppSchema://url/:param
 */

// 网络跳转路由模式
FOUNDATION_EXTERN NSString *const ZCHTTPRouteSchema;
FOUNDATION_EXTERN NSString *const ZCHTTPsRouteSchema;
// WEB交互路由跳转模式
FOUNDATION_EXTERN NSString *const ZCWebHandlerRouteSchema;
// 回调通信
FOUNDATION_EXTERN NSString *const ZCComponentsCallBackHandlerRouteSchema;
// 未知路由
FOUNDATION_EXTERN NSString *const ZCUnknownHandlerRouteSchema;

#pragma mark - 路由表

// 导航栏 Push
FOUNDATION_EXTERN NSString *const ZCNavPushRoute;

// 导航栏 Present
FOUNDATION_EXTERN NSString *const ZCNavPresentRoute;

// 组件通信回调
FOUNDATION_EXTERN NSString *const FKComponentsCallBackRoute;

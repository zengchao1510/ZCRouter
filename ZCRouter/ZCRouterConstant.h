//
//  ZCRouterConstant.h
//  LiaoBa-Man
//
//  Created by zengchao on 2020/4/20.
//  Copyright © 2020 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 路由模式

// 网络路由
FOUNDATION_EXTERN NSString *const ZCHTTPRouteSchema;
FOUNDATION_EXTERN NSString *const ZCHTTPsRouteSchema;

// 照片选择器
FOUNDATION_EXTERN NSString *const ModulePhotopicker;

// 定位
#define DefaultRouterPatternLocation(reGeocode) [NSString stringWithFormat:@"location/%@",reGeocode]
// 照片选择器
#define ModulePhotopickerRouterPatternType(type) [NSString stringWithFormat:@"type/%@",type]
// 页面导航
#define DefaultRouterPatternVc(vc) [NSString stringWithFormat:@"vc/%@",vc]
#define DefaultRouterPatternVcAndType(vc, type) [NSString stringWithFormat:@"vc/%@/type/%@",vc,type]
#define DefaultRouterPatternVcAndTypeAnimation(vc, type, animation) [NSString stringWithFormat:@"vc/%@/type/%@/animation/%@",vc,type,animation]


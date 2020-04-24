//
//  ZCRouter.h
//  NightLove
//
//  Created by zengchao on 2019/2/26.
//  Copyright © 2019 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCRouter : NSObject

+ (void)addRouterByPattern:(NSString *)pattern
                   handler:(void (^)(NSDictionary *, void (^)(id params)))handler;

+ (void)addRouterByScheme:(NSString *)scheme
                  handler:(void (^)(NSDictionary *, void (^)(id params)))handler;

+ (void)routePathComponent:(NSString *)pathComponent
                    params:(NSDictionary * _Nullable)params;

+ (void)routePathComponent:(NSString *)pathComponent
                    params:(NSDictionary * _Nullable)params
                   handler:(void (^ _Nullable )(NSDictionary * _Nullable))handler;

+ (void)routeScheme:(NSString *)scheme
      pathComponent:(NSString *)pathComponent
             params:(NSDictionary *)params;

+ (void)routeURL:(NSString *)URL;

@end

NS_ASSUME_NONNULL_END

//
//  ZCRouter.m
//  NightLove
//
//  Created by zengchao on 2019/2/26.
//  Copyright © 2019 zengchao. All rights reserved.
//

#import "ZCRouter.h"
#import "ZCRouterParse.h"
#import "ZCRouterRequest.h"
#import "NSString+URLEncode.h"

static NSMutableDictionary *GlobalRoutesMap = nil;
static NSString            *ZCDefaultRouteSchema = @"ZCDefaultRouteSchema";

@implementation ZCRouter

// 添加路由规则
+ (void)addRouterByPattern:(NSString *)pattern
                   handler:(void (^)(NSDictionary *, void (^)(id params)))handler {
    
    [self addRouterByScheme:ZCDefaultRouteSchema pattern:pattern handler:handler];
}

+ (void)addRouterByScheme:(NSString *)scheme
                  handler:(void (^)(NSDictionary *, void (^)(id params)))handler {
    
    [self addRouterByScheme:scheme pattern:nil handler:handler];
}

+ (void)addRouterByScheme:(NSString *)scheme
                  pattern:(NSString *)pattern
                  handler:(void (^)(NSDictionary *, void (^)(id params)))handler {
    
    if (!scheme) {
        
        scheme = ZCDefaultRouteSchema;
    }
    
    if (!pattern) {
        
        ZCRouterParse *router = [self getGlobalRoutesMap][scheme];
        if (!router) {
            
            router = [[ZCRouterParse alloc] initWithScheme:scheme handler:handler];
            GlobalRoutesMap[scheme] = router;
        } else {
            
            router.handle = handler;
        }
        return;
    }
    
    NSMutableDictionary *routers = [self getGlobalRoutesMap][scheme];
    if (!routers) {
        
        routers = [NSMutableDictionary dictionary];
        GlobalRoutesMap[scheme] = routers;
    }
    
    ZCRouterParse *router = routers[pattern];
    if (!router) {
        
        router = [[ZCRouterParse alloc] initWithScheme:scheme pattern:pattern handler:handler];
        routers[pattern] = router;
    } else {
        
        router.handle = handler;
    }
}

+ (NSMutableDictionary *)getGlobalRoutesMap {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        GlobalRoutesMap = [NSMutableDictionary dictionary];
    });
    return GlobalRoutesMap;
}

+ (void)routeURL:(NSString *)URL {
    
    URL = [URL stringByURLEncode];
    [self routeURL:[NSURL URLWithString:URL] params:nil handler:nil];
}

+ (void)routeScheme:(NSString *)scheme
      pathComponent:(NSString *)pathComponent
             params:(NSDictionary *)params {
    
    NSString *url = [NSString stringWithFormat:@"%@://%@", scheme, pathComponent];
    [self routeURL:[NSURL URLWithString:url] params:params handler:nil];
}

+ (void)routePathComponent:(NSString *)pathComponent
                    params:(NSDictionary * _Nullable)params {
    
    [self routePathComponent:pathComponent params:params handler:nil];
}

+ (void)routePathComponent:(NSString *)pathComponent
                    params:(NSDictionary * _Nullable)params
                   handler:(void (^ _Nullable)(NSDictionary * _Nullable))handler {
    
    pathComponent = [pathComponent stringByURLEncode];
    NSString *url = [NSString stringWithFormat:@"%@://%@", ZCDefaultRouteSchema, pathComponent];
    [self routeURL:[NSURL URLWithString:url] params:params handler:handler];
}

+ (void)routeURL:(NSURL *)url
          params:(NSDictionary *)params
         handler:(void (^ _Nullable)(NSDictionary *))handler {
    
    ZCRouterRequest *request = [[ZCRouterRequest alloc] initWithURL:url params:params];
    id routers = [self getGlobalRoutesMap][request.scheme];
    if (![routers isKindOfClass: [NSMutableDictionary class]]) {
        
        ZCRouterParse *router = routers;
        [router startRequest:request handlerBlock:^BOOL(NSDictionary *params, NSError *error) {
            
            if (!error) {
                
                if (router.handle) {
                    
                    router.handle(params, handler);
                }
                return YES;
            } else {
                
                return NO;
            }
        }];
        return;
    }
    
    NSArray *paths = request.paths;
    NSString *pattern = @"";
    for (int i = 0; i < paths.count; i+=2) {
        
        pattern = [NSString stringWithFormat:@"%@%@:/", pattern, paths[i]];
    }
    
    ZCRouterParse *router = [routers objectForKey:pattern];
    if (!router) {
        
        return;
    }
    for (int i = 0; i < paths.count; i += 2) {
        
        id value;
        if (i + 1 < paths.count) {
            
            value = paths[i + 1];
        } else {
            
            value = nil;
        }
        [router setValue:value forPatternPathKey:paths[i]];
    }
    
    [router startRequest:request handlerBlock:^BOOL(NSDictionary *params, NSError *error) {
        
        if (!error) {
            
            if (router.handle) {
                
                router.handle(params, handler);
            }
            return YES;
        } else {
            
            return NO;
        }
    }];
}


@end
















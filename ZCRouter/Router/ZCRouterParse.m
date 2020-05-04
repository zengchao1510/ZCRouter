//
//  ZCRouterParse.m
//  NightLove
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018年 zengchao. All rights reserved.
//

#import "ZCRouterParse.h"
#import "ZCRouterRequest.h"

@interface  ZCRouterParse ()

@property (nonatomic, copy) NSURL *url;

@property (nonatomic, copy)   NSString *domain;
@property (nonatomic, copy)   NSArray  *patternPathComponents;

@property (nonatomic, strong) NSMutableDictionary *patterns;
@property (nonatomic, strong) NSMutableDictionary *handles;

@end

@implementation ZCRouterParse

- (instancetype)initWithUrl:(NSURL *)url {
    
    if (!url) {
        
        return nil;
    }

    self = [super init];
    if (self) {
        
        self.scheme     = url.scheme;
        self.currentUrl = url;
    }
    return self;
}

- (instancetype)initWithScheme:(NSString *)scheme
                       handler:(void (^)(NSDictionary *, void (^)(id params)))handler {
    
    NSParameterAssert(scheme != nil);
    
    self = [super init];
    if (self) {
        
        self.scheme  = scheme;
        self.handle  = handler;
    }
    return self;
}

- (instancetype)initWithScheme:(NSString *)scheme
                        domain:(NSString *)domain
                       pattern:(NSString *)pattern
                       handler:(void (^)(NSDictionary *, void (^)(id params)))handler {
    
    NSParameterAssert(domain != nil);
    NSParameterAssert(scheme != nil);
    NSParameterAssert(pattern != nil);
    
    if ((self = [super init])) {
        
        self.domain  = domain;
        self.scheme  = scheme;
        if (handler) {
            
            [self addHandle:handler byPattern:pattern];
        }
        
        if ([pattern characterAtIndex:0] == '/') {
            
            pattern = [pattern substringFromIndex:1];
        }
        self.patternPathComponents = [pattern componentsSeparatedByString:@"/"];
    }
    return self;
}

- (void)startRequest:(ZCRouterRequest *)request
             pattern:(NSString *)pattern
        handlerBlock:(BOOL (^)(NSDictionary *, NSError *))handlerBlock {
    
    if (!request) {
        
        NSError *error = [NSError errorWithDomain:@"zc.router.com" code:1 userInfo:@{@"message": @"无效的请求~"}];
        handlerBlock(nil, error);
        return;
    }
    
    NSArray *paths                = [request paths];
    NSDictionary *queryMap        = [request qureyParams];
    NSDictionary *additionalMap   = [request additionalParams];
    NSString *domain              = [request domain];
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    [muDic setValue:queryMap forKey:@"query"];
    [muDic setValue:paths forKey:@"paths"];
    [muDic setValue:additionalMap forKey:@"params"];
    [muDic setValue:domain forKey:@"domain"];
    [muDic setValue:[[self.patterns valueForKey:pattern] copy] forKey:@"pathComponent"];
    [muDic setValue:request.url.absoluteString forKey:@"url"];
    handlerBlock([muDic copy], nil);
}

- (void)setValue:(NSString *)value
             key:(NSString *)key
         pattern:(NSString *)pattern {
    
    if ([self.patterns valueForKey:pattern]) {
        
        NSMutableDictionary *muDic = [self.patterns objectForKey:pattern];
        [muDic setValue:value forKey:key];
    } else {
        
        NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
        [muDic setValue:value forKey:key];
        [self.patterns setValue:muDic forKey:pattern];
    }
}

- (void)addHandle:(void (^)(NSDictionary *, void (^)(id params)))handle
        byPattern:(NSString *)pattern {
    
    [self.handles setObject:handle forKey:pattern];
}

- (void (^)(NSDictionary *, void (^)(id params)))getHandleByPattern:(NSString *)pattern {
    
    return self.handles[pattern];
}

- (NSMutableDictionary *)handles {
    
    if (!_handles) {
        
        _handles = [NSMutableDictionary dictionary];
    }
    return _handles;
}

- (NSMutableDictionary *)patterns {
    
    if (!_patterns) {
        
        _patterns = [NSMutableDictionary dictionary];
    }
    return _patterns;
}

@end










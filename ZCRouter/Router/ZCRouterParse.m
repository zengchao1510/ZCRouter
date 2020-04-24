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

// url地址列表
@property (nonatomic, strong) NSMutableArray *urlList;

@property (nonatomic, copy) NSURL *url;

@property (nonatomic, copy) NSString *pattern;
@property (nonatomic, copy) NSArray *patternPathComponents;
@property (nonatomic, strong) NSMutableDictionary *patternPathParams;

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
        [self.urlList addObject:url];
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
                       pattern:(NSString *)pattern
                       handler:(void (^)(NSDictionary *, void (^)(id params)))handler {
    
    NSParameterAssert(pattern != nil);
    NSParameterAssert(scheme != nil);
    
    if ((self = [super init])) {
        
        self.pattern = pattern;
        self.scheme  = scheme;
        self.handle  = handler;
        if ([pattern characterAtIndex:0] == '/') {
            
            pattern = [pattern substringFromIndex:1];
        }
        self.patternPathComponents = [pattern componentsSeparatedByString:@"/"];
    }
    return self;
}

- (void)startRequest:(ZCRouterRequest *)request
        handlerBlock:(BOOL (^)(NSDictionary *, NSError *))handlerBlock {
    
    if (!request) {
        
        NSError *error = [NSError errorWithDomain:@"zc.router.com" code:1 userInfo:@{@"message": @"无效的请求~"}];
        handlerBlock(nil, error);
        return;
    }
    
    NSArray *paths                = [request paths];
    NSDictionary *queryMap        = [request qureyParams];
    NSDictionary *additionalMap   = [request additionalParams];
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    [muDic setValue:queryMap forKey:@"query"];
    [muDic setValue:paths forKey:@"paths"];
    [muDic setValue:additionalMap forKey:@"params"];
    [muDic setValue:self.pattern forKey:@"pattern"];
    [muDic setValue:self.patternPathParams.copy forKey:@"pathComponent"];
    [muDic setValue:request.url.absoluteString forKey:@"url"];
    handlerBlock([muDic copy], nil);
}

- (void)addURL:(NSURL *)URL {
    
    if (URL) {
        
        [self.urlList addObject:URL];
    }
}

- (void)removeURL:(NSURL *)URL {
    
    if (URL && [self.urlList containsObject:URL]) {
        
        [self.urlList removeObject:URL];
    }
}

- (void)setValue:(NSString *)value forPatternPathKey:(NSString *)key {
    
    [self.patternPathParams setValue:value forKey:key];
}

- (NSMutableDictionary *)patternPathParams {
    
    if (!_patternPathParams) {
        
        _patternPathParams = [NSMutableDictionary dictionary];
    }
    return _patternPathParams;
}

@end










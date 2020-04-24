//
//  ZCRouterParse.h
//  NightLove
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018年 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCRouterRequest;

NS_ASSUME_NONNULL_BEGIN

@interface ZCRouterParse : NSObject

@property (nonatomic, copy) NSURL    *currentUrl;
@property (nonatomic, copy) NSString *scheme;

@property (nonatomic, copy) void (^handle)(NSDictionary *, void (^)(id params));

- (instancetype)initWithUrl:(NSURL *)url;

- (instancetype)initWithScheme:(NSString *)scheme
                       handler:(void (^)(NSDictionary *, void (^)(id params)))handler;

- (instancetype)initWithScheme:(NSString *)scheme
                       pattern:(NSString *)pattern
                       handler:(void (^)(NSDictionary *, void (^)(id params)))handler;

- (void)startRequest:(ZCRouterRequest *)request
        handlerBlock:(BOOL (^)(NSDictionary *, NSError *))handlerBlock;

- (void)addURL:(NSURL *)URL;

- (void)removeURL:(NSURL *)URL;

- (void)setValue:(NSString *)value forPatternPathKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END

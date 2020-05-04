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
                        domain:(NSString *)domain
                       pattern:(NSString *)pattern
                       handler:(void (^)(NSDictionary *, void (^)(id params)))handler;

- (void)startRequest:(ZCRouterRequest *)request
             pattern:(NSString *)pattern
        handlerBlock:(BOOL (^)(NSDictionary *, NSError *))handlerBlock;

- (void)setValue:(NSString *)value
             key:(NSString *)key
         pattern:(NSString *)pattern;

- (void)addHandle:(void (^)(NSDictionary *, void (^)(id params)))handle
        byPattern:(NSString *)pattern;

- (void (^)(NSDictionary *, void (^)(id params)))getHandleByPattern:(NSString *)pattern;


@end

NS_ASSUME_NONNULL_END

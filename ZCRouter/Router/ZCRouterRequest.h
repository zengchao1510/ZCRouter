//
//  ZCRouterRequest.h
//  NightLove
//
//  Created by zengchao on 2019/2/24.
//  Copyright © 2019 zengchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCRouterRequest : NSObject

@property (nonatomic, copy, readonly) NSURL        *url;
@property (nonatomic, copy, readonly) NSString     *scheme;
@property (nonatomic, copy, readonly) NSArray      *paths;
@property (nonatomic, copy, readonly) NSString     *path;
@property (nonatomic, copy, readonly) NSDictionary *qureyParams;
@property (nonatomic, copy, readonly) NSDictionary *additionalParams;

- (instancetype)initWithURL:(NSURL *)URL;

- (instancetype)initWithURL:(NSURL *)URL
                     params:(nullable NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END

//
//  ZCRouterRequest.m
//  NightLove
//
//  Created by zengchao on 2019/2/24.
//  Copyright © 2019 zengchao. All rights reserved.
//

#import "ZCRouterRequest.h"


@interface ZCRouterRequest ()

@property (nonatomic, copy) NSURL        *url;
@property (nonatomic, copy) NSDictionary *qureyParams;
@property (nonatomic, copy) NSArray      *paths;
@property (nonatomic, copy) NSString     *path;
@property (nonatomic, copy) NSDictionary *additionalParams;
@property (nonatomic, copy) NSString     *scheme;

@end

@implementation ZCRouterRequest

- (instancetype)initWithURL:(NSURL *)URL {
    
    return [self initWithURL:URL params: nil];
}

- (instancetype)initWithURL:(NSURL *)URL
                     params:(nullable NSDictionary *)params {
    
    if (!URL) {
        
        return nil;
    }
    
    self = [super init];
    if (self) {
        
        self.url = URL;
        self.scheme = URL.scheme;
        NSURLComponents *components = [NSURLComponents componentsWithString:URL.absoluteString];
        if (components.host.length > 0 && [components.host rangeOfString:@"."].location == NSNotFound) {
            // 将host设置到路径当中
            NSString *host  = components.host;
            components.host = @"/";
            
            NSString *pathComponents = [host stringByAppendingPathComponent:(components.percentEncodedPath ?: @"")];
            components.percentEncodedPath = pathComponents;
        }
        
        NSString *path = [components percentEncodedPath];
        if (path.length > 0 && [path characterAtIndex:0] == '/') {
            // 删除path路径第一个/
            path = [path substringFromIndex:1];
        }
        
        if (path.length > 0 && [path characterAtIndex:path.length - 1] == '/') {
            // 删除path路径最后一个/
            path = [path substringToIndex:path.length - 1];
        }
        
        if (path.length > 0) {
            
            self.paths = [path componentsSeparatedByString:@"/"];
        }
        self.path = path;
        
        NSMutableDictionary *queryMap = [NSMutableDictionary dictionary];
        NSArray *items = [components.query componentsSeparatedByString:@"&"];
        for (NSString *item in items) {
            
            NSArray *keyAndValue = [item componentsSeparatedByString:@"="];
            if (keyAndValue && keyAndValue.count == 2) {
                
                [queryMap setValue:keyAndValue[1] forKey:keyAndValue[0]];
            } else if (keyAndValue && keyAndValue.count == 1) {
                
                [queryMap setValue:@"" forKey:keyAndValue[0]];
            }
        }
        self.qureyParams = [queryMap copy];
        self.additionalParams = params;
    }
    return self;
}

@end

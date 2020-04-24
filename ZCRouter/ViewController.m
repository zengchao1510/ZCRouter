//
//  ViewController.m
//  ZCRouter
//
//  Created by zengchao on 2020/4/24.
//  Copyright © 2020 zengchao. All rights reserved.
//

#import "ViewController.h"
#import "ZCRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)present {
    
    [ZCRouter routePathComponent:@"vc/ZCViewController/type/present/animation/1" params:nil];
}


@end

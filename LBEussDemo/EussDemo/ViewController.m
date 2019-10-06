//
//  ViewController.m
//  EussDemo
//
//  Created by mc on 2019/10/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"

#import "AFNetworking.h"
#import "JSONKit.h"
//天气

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadJsonWeatherData2];
}

-(void)loadJsonWeatherData2
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    [manager GET:@"http://api.budejie.com/api/api_open.php?a=tag_recommend&action=sub&c=topic" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}


@end

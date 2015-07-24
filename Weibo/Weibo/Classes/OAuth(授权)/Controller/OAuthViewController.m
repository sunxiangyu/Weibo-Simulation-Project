//
//  OAuthViewController.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/22.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1229422540&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = (int)(range.location + range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
    }
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1229422540";
    params[@"client_secret"] = @"87f0fa27c3d07a2bc919f9c5148a2dfb";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WBLog(@"请求成功--- %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WBLog(@"请求失败--- %@", error);
    }];
    
}

@end

//
//  CSWebViewController.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/10.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "CSWebViewController.h"

@interface CSWebViewController ()

@end

@implementation CSWebViewController{
    UIWebView *_mainWebView;
    NSString *_path;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
}

- (void)initWebView{
    _mainWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
     NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_path]];
    _mainWebView.delegate = self;
    [_mainWebView loadRequest:request];
    [self.view addSubview:_mainWebView];

}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    
}
@end

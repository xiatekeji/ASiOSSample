//
//  HTML5ViewController.h
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "HTML5ViewController.h"
#import "ASModalCenterControll.h"
@interface HTML5ViewController ()<UIWebViewDelegate, ASModalCenterControllProtocol>

@end

@implementation HTML5ViewController{
    UIWebView *_webView;
    NSString *_path;
}

-(void)pushControllerWithParameters:( NSDictionary *)parameters
{
    if ([parameters objectForKey:@"url"]) {
        _path = [parameters objectForKey:@"url"];
         
    }
    if ( [parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initWebview];
}

-(void)initWebview
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _webView.delegate = self;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_path]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


@end

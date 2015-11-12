//
//  HTML5ViewController.h
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "ModalCenterReform.h"
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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(95, 250, 200, 100);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"push baidu" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(95, 350, 200, 100);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"push home" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTintColor:[UIColor blueColor]];
    [self.view addSubview:btn1];

}
- (void)home:(UIButton *)sender{
    [[ASModalCenterControll shareModalCenter] popHomeViewControllerWithAnimation:YES];
}
- (void)push:(UIButton *)sender{
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"baidu" andParameters:nil];
    [[ASModalCenterControll shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
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

//
//  ASCartViewController.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/11.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//

#import "ASCartViewController.h"


@interface ASCartViewController ()

@end

@implementation ASCartViewController{

}
- (void)skipPageProtocol:(NSDictionary *)parameters{
    if ([parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}
- (instancetype)initWithViewModel:(ASCartViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark  Activity
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
    [self initItemButton];
}
- (void)viewWillAppear: (BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidDisappear: (BOOL)animated {
    [super viewWillDisappear: animated];

    
}
#pragma mark Layout
- (void)initWebView{
    self.mainWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.mainWebView.backgroundColor = [UIColor clearColor];
    self.mainWebView.delegate = self;
    self.mainWebView.scalesPageToFit = YES;
	self.mainWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;


    [self.view addSubview:self.mainWebView];

}
- (void)initItemButton{
    }
#pragma mark JS Bridege




@end

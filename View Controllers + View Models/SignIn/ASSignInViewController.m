//
//  ASSignInViewController.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/15.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//


#import "ASSignInViewController.h"
#import "ASNavigator.h"


@implementation ASSignInViewController{
    BOOL _isAuthed;
    NSURLRequest *_originRequest;
    NSURL *_signInUrl;
}
- (void)skipPageProtocol:(NSDictionary *)parameters{
    
}
#pragma mark  Activity
- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear: (BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidDisappear: (BOOL)animated {
    [super viewWillDisappear: animated];
    
    
}

#pragma mark Layout
#pragma mark Layout

- (IBAction)back:(UIButton *)sender {
    if(self.closedSignIn) {
        self.closedSignIn(nil);
    }
    [[ASNavigator shareModalCenter] dismissCurrentModalViewControlleAnimation:YES completion:nil];
}

@end


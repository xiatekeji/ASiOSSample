//
//  ASSignInViewController.h
//  PhotoBook
//
//  Created by XiaoSong on 15/9/15.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCartViewModel.h"
@class ASSignInViewController;
typedef void(^SignInComplete)(id returnVlaue);
typedef void(^CloseSignIn)(id returnVlaue);

@interface ASSignInViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (strong ,nonatomic) ASCartViewModel *viewModel;
@property (strong ,nonatomic)SignInComplete complete;
@property (strong ,nonatomic)CloseSignIn closedSignIn;

@end

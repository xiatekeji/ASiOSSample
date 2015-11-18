//
//  ASCartViewController.h
//  PhotoBook
//
//  Created by XiaoSong on 15/9/11.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCartViewModel.h"
@interface ASCartViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate>

- (instancetype)initWithViewModel:(ASCartViewModel *)viewModel;

@property (strong ,nonatomic) ASCartViewModel *viewModel;
@property (strong ,nonatomic) UIWebView *mainWebView;
@end

//
//  ASSignInViewController.h
//  PhotoBook
//
//  Created by XiaoSong on 15/9/15.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASNavigator.h"

@class ASSignInViewModel;

@interface ASSignInViewController : UIViewController<ASNavigatable>

@property(nonatomic, strong, nonnull) ASSignInViewModel* viewModel;

@end

//
//  ASBookEditViewController.h
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASNavigator.h"
#import "ASBookEditViewModel.h"
@interface ASBookEditViewController : UIViewController<ASNavigatable>
@property (strong ,nonatomic) ASBookEditViewModel *viewModel;
@end

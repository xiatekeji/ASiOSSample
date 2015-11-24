//
//  ASOptionsView.h
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASSpecOptionVIewModel.h"
@interface ASOptionsView : UIView
- (instancetype)init __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;
- (instancetype)initWithOptionViewModel:(ASSpecOptionViewModel *)viewModel
                                  frame:(CGRect)frame;
- (void)selectOptionWithType:(ASOptionType )type;

@end

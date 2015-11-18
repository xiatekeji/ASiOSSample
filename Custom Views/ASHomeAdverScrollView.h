//
//  ASHomeAdverScrollView.h
//  PhotoBook
//
//  Created by XiaoSong on 15/9/7.
//  Copyright (c) 2015年 Logictech . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHomeViewModel.h"
@interface ASHomeAdverScrollView : UIView

- (instancetype)initWithViewModel:(ASHomeViewModel *)viewModel;

@property (strong ,nonatomic) ASHomeViewModel *viewModel;

@property (strong ,nonatomic) UITapGestureRecognizer *singleTap;
//@property (assign ,nonatomic) SEL tapAction;

@end

//
//  ASCartViewModel.h
//  PhotoBook
//
//  Created by XiaoSong on 15/9/11.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//

#import "RVMViewModel.h"


@interface ASCartViewModel : RVMViewModel
@property (nonatomic ,copy ) NSString *pageTitle; //导航栏标题
@property (nonatomic ,copy ) NSString *editBtnTitle; //按钮title

@property (nonatomic ,strong ) NSURL *webPath;

@property(nonatomic, readonly, getter=backHandlerIsEnabled) BOOL backHandlerEnabled;



@end

//
//  ASTrialViewController.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/9.
//  Copyright (c) 2015年 Logictech . All rights reserved.
//

#import "ASTrialViewController.h"

#import <Masonry/Masonry.h>


/**
 * @brief 在Trial流程中不被显示的View Controller的类的数组，元素类型为Class。
 */
static NSArray* _suppressedViewControllerClasses;
	
@interface ASTrialViewController()<UIViewControllerAnimatedTransitioning> {

	
	UIView* _fromView;
}

@end

#pragma mark -

@implementation ASTrialViewController



#pragma mark Activity

- (void)viewDidLoad{
	[super viewDidLoad];
	
	self.title = @"$5 Trial";


}
- (void)viewWillAppear: (BOOL)animated {
	[super viewWillAppear: animated];
}

- (void)viewDidDisappear: (BOOL)animated {
	[super viewWillDisappear: animated];
	
	
}

#pragma mark Layout

#pragma mark Private



@end

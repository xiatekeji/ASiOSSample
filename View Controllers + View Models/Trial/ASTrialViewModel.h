
//
//  ASTrialViewModel.h
//  PhotoBook
//
//  Created by XiaoSong on 15/9/9.
//  Copyright (c) 2015年 Logictech . All rights reserved.
//
#import "RVMViewModel.h"

typedef NS_ENUM(NSInteger, ASTrialAction) {
	ASTrialActionNone,
	ASTrialActionPhotoBook,
	ASTrialActionFrame,
	ASTrialActionCanvas,
	ASTrialActionPrints
};

#pragma mark -

@interface ASTrialViewModel : RVMViewModel



@property(nonatomic, readonly) NSArray* products;



@end

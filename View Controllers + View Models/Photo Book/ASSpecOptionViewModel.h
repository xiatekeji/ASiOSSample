//
//  ASSpecOptionVIewModel.h
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "ASOptionViewModel.h"
#import <Foundation/Foundation.h>
// 选项
typedef NS_ENUM(NSUInteger, ASOptionType) {
    ASColorOption = 0,
    ASSizeOption = 1 << 0,
    ASCoverOption = 1 << 1,
};
@interface ASSpecOptionViewModel : NSObject
@property (assign ,nonatomic) ASOptionType option;
@property (strong ,nonatomic) ASOptionViewModel *sizeOption;
@property (strong ,nonatomic) ASOptionViewModel *colorOption;
@property (strong ,nonatomic) ASOptionViewModel *coverOption;
- (ASOptionViewModel *)fetchOptionViewModelWithType:(ASOptionType)type;
@end

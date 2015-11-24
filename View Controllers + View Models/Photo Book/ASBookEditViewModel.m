//
//  ASBookEditViewModel.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "ASSpecOptionVIewModel.h"
#import "ASBookEditViewModel.h"

@implementation ASBookEditViewModel
- (instancetype)init{
    self = [super init];
    _options = [[ASSpecOptionViewModel alloc]init];
    return self;
}
@end

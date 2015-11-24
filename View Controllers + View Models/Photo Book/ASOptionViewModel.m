
//
//  ASOptionViewModel.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASOptionViewModel.h"

@implementation ASOptionViewModel
- (void)selectButton:(UIButton *)selectedBtn
    unselectedButton:(UIButton *)unselectedBtn
               index:(NSInteger)index{
    unselectedBtn.layer.borderColor = [UIColor clearColor].CGColor;
    selectedBtn.selected = YES;
    selectedBtn.layer.borderColor = [UIColor blueColor].CGColor;
    self.currentIndex = index;
    
}
@end

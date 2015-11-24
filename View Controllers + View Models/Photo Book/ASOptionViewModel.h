//
//  ASOptionViewModel.h
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class ASOptionModel;
@interface ASOptionViewModel : NSObject
@property (strong ,nonatomic) NSArray <ASOptionModel *>* options;
@property (assign ,nonatomic) NSInteger currentIndex;
- (void)selectButton:(UIButton *)selectedBtn
    unselectedButton:(UIButton *)unselectedBtn
               index:(NSInteger)index;
@end

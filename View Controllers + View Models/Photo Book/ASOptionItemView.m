//
//  ASOptionItemVIew.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASOptionItemView.h"

@implementation ASOptionItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.itemBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-30);
        self.itemName = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_itemBtn.frame), frame.size.width, 30)];
        self.itemName.textAlignment = NSTextAlignmentCenter;
        self.itemName.textColor = [UIColor blackColor];\
        self.itemBtn.layer.borderWidth = 3;
        self.itemBtn.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:self.itemBtn];
        [self addSubview:self.itemName];
    }
    return self;
}

@end

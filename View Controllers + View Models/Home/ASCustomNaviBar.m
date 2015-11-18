//
//  ASCustomNaviBar.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/8.
//  Copyright (c) 2015年 Logictech . All rights reserved.
//
#import <Masonry/Masonry.h>
#import "ASCustomNaviBar.h"

#define KTitleText @"Artisan State"
#define buttonItemWH  31
#define backImageAlpha  0.3f
#define titleFont  20


@implementation ASCustomNaviBar{
    UIImageView *_blackImage;//黑色状态栏
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _blackImage = [[UIImageView alloc]init];
        _blackImage.backgroundColor = [UIColor blackColor];
        self.backImage = [[UIImageView alloc]init];
        self.backImage.backgroundColor = [UIColor blackColor];
        self.backImage.alpha = backImageAlpha;
        
        self.leftBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBarItem setBackgroundImage:[UIImage imageNamed:@"icon_leftItem_maskBtn"] forState:UIControlStateNormal];
        self.rightBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightBarItem setBackgroundImage:[UIImage imageNamed:@"icon_shopping_cart"] forState:UIControlStateNormal];
        
        self.productTitle = [[UILabel alloc]init];
        self.productTitle.font = [UIFont boldSystemFontOfSize:titleFont];
        self.productTitle.text = KTitleText ;
        self.productTitle.textColor = [UIColor whiteColor];
        
        [self addSubview:_blackImage];
        [self addSubview:self.backImage];
        [self addSubview:self.productTitle];
        [self addSubview:self.leftBarItem];
        [self addSubview:self.rightBarItem];
        [self setAutoLayoutConstraints];
   
 
    }
    return self;
}
// 设置约束
- (void)setAutoLayoutConstraints{

    [_blackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.left.and.right.equalTo(self).with.offset(0);
        make.height.equalTo(@20);
    }];
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_leftBarItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(_blackImage.mas_bottom).with.offset(5);
        make.width.and.height.equalTo(@buttonItemWH);
    }];

    [_productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftBarItem.mas_right).with.offset(5);
        make.centerY.equalTo(_leftBarItem.mas_centerY);
        make.width.equalTo(@200);
        make.top.equalTo(_leftBarItem);
    }];
    [_rightBarItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_leftBarItem.mas_width);
        make.height.equalTo(@(buttonItemWH*(318.0/419.0)));
        make.centerY.equalTo(_leftBarItem.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
}
@end

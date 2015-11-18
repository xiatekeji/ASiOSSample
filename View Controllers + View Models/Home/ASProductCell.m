//
//  ASProductCell.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/8.
//  Copyright (c) 2015年 Logictech . All rights reserved.
//
#import <Masonry/Masonry.h>
#import "ASProductCell.h"
static CGFloat imageWidth = 55.0f;
static CGFloat gap = 15.0f;
@implementation ASProductCell{
    UIImageView *_productImage;
    UIImageView *_arrow;
    UILabel *_productName;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = 0;
        CGFloat imageScale  = 224.0/276.0;
        _productImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, gap, imageWidth, imageWidth*imageScale)];
        _productName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_productImage.frame)+gap,self.frame.size.height/2,250, gap*2)];
        _productName.font = [UIFont systemFontOfSize:22];
        _productName.textColor = [UIColor darkGrayColor];
        _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_right_arrow"]];
        [self.contentView addSubview:_arrow];
        [self.contentView addSubview:_productImage];
        [self.contentView addSubview:_productName];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.equalTo(@15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView).with.offset(-gap);
        }];
        
        
    }
    return self;
}
- (void)loadDataWithImage:(NSString *)image andName:(NSString *)name{
    _productImage.image = [UIImage imageNamed:image];
    _productName.text = name;
}
+ (NSString *)productCell{
    return @"Product";
}
@end

//
//  ASOptionsView.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASOptionsView.h"
#import "ASSpecOptionVIewModel.h"
#import "ASOptionItemView.h"
#import "ASOptionModel.h"
@interface ASOptionsView ()
@property (strong ,nonatomic) UIScrollView *mainScrollView;
@property (strong ,nonatomic) UIButton *cancelButton;
@property (strong ,nonatomic) NSMutableArray <ASOptionItemView *>*itemsView;
@property (strong ,nonatomic) ASSpecOptionViewModel *viewModel;
@property (strong ,nonatomic) ASOptionViewModel *optionViewModel;
@property (assign ,nonatomic) CGRect oranginRect;
@end
@implementation ASOptionsView

- (instancetype)initWithOptionViewModel:(ASSpecOptionViewModel *)viewModel
                                  frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _viewModel = viewModel;
        self.hidden = YES;
        _oranginRect = frame;
        [self initCancelButton];
       
    }
    return self;
}
- (void)initCancelButton{
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.backgroundColor = [UIColor yellowColor];
    self.cancelButton.frame = CGRectMake(20, 0, 30, 30);
    [self.cancelButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

- (void)dismiss:(UIButton *)sender{
    CGRect rect = self.frame;
    rect.origin.y = _oranginRect.origin.y;

    [UIView animateWithDuration:0.4f animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self.mainScrollView removeFromSuperview];
        self.mainScrollView = nil;
        self.itemsView = nil;
    }];
}
- (void)selectOptionWithType:(ASOptionType )type{
    [self initScrollViewWithType:type];
    CGRect rect = self.frame;
    rect.origin.y = _oranginRect.origin.y-_oranginRect.size.height;
    self.hidden = NO;
    [UIView animateWithDuration:0.4f animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)initScrollViewWithType:(ASOptionType )type{
    _optionViewModel = [self.viewModel fetchOptionViewModelWithType:type];
    self.itemsView = [[NSMutableArray alloc]initWithCapacity:_optionViewModel.options.count];
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cancelButton.frame), self.frame.size.width, self.frame.size.height-CGRectGetMaxY(self.cancelButton.frame))];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.mainScrollView];

    [_optionViewModel.options enumerateObjectsUsingBlock:^(ASOptionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ASOptionItemView *view = [[ASOptionItemView alloc]initWithFrame:CGRectMake(idx*self.mainScrollView.frame.size.height, 0, self.mainScrollView.frame.size.height, self.mainScrollView.frame.size.height)];
        view.itemName.text = obj.name;
        [view.itemBtn addTarget:self action:@selector(itemDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [view.itemBtn setImage:[UIImage imageNamed:obj.imageName] forState:UIControlStateNormal];
        view.itemBtn.tag = idx;
        if (idx == _optionViewModel.currentIndex) {
          
          view.itemBtn.layer.borderColor = [UIColor blueColor].CGColor;
          self.mainScrollView.contentOffset = CGPointMake(view.frame.origin.x, 0);
        }
        [self.mainScrollView addSubview:view];
        [self.itemsView addObject:view];
    }];
    ASOptionItemView *lastView = [self.itemsView lastObject];
    self.mainScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastView.frame), 0);
    
}
- (void)itemDidSelected:(UIButton *)sender{
      ASOptionItemView *lastView = [self.itemsView objectAtIndex:_optionViewModel.currentIndex];
    [_optionViewModel selectButton:sender
                  unselectedButton:lastView.itemBtn
                  index:sender.tag];


}

@end

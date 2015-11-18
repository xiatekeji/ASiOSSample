//
//  ASHomeAdverScrollView.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/7.
//  Copyright (c) 2015年 Logictech . All rights reserved.
//
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "ASHomeAdverScrollView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#define KTilteLabelBackGround 0xF54437
@implementation ASHomeAdverScrollView{
    UIScrollView  *_mainScrollView;
    UIPageControl *_page;
    NSUInteger _index;
    UITapGestureRecognizer *_singleTap;
}
- (instancetype)initWithViewModel:(ASHomeViewModel *)viewModel{
    _viewModel = viewModel;
    if (_viewModel) {
        self = [super initWithFrame:_viewModel.homeRect];
        if (self) {
            self.backgroundColor = [UIColor clearColor];
            _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _viewModel.homeRect.size.width,_viewModel.homeRect.size.height)];
            _mainScrollView.backgroundColor = [UIColor clearColor];
            _mainScrollView.pagingEnabled = YES;
            _mainScrollView.delegate = _viewModel;
            _mainScrollView.showsHorizontalScrollIndicator = NO;
            _mainScrollView.bounces = NO;
            _mainScrollView.contentSize = CGSizeMake(_viewModel.homeRect.size.width*_viewModel.imageArray.count, 0);
            _page = [[UIPageControl alloc]initWithFrame:CGRectMake( _viewModel.homeRect.size.width-20*_viewModel.imageArray.count, _viewModel.homeRect.size.height-20, 20*_viewModel.imageArray.count, 20)];

            RAC(_page, currentPage) = RACObserve(_viewModel, pageIndex);
            _singleTap = [[UITapGestureRecognizer alloc]init];
            [_mainScrollView addGestureRecognizer:_singleTap];
            [self layOutMainScrollSubviews];
            [self addSubview:_mainScrollView];
            [self addSubview:_page];
        }
        
        
        return self;
        
    }else{
        NSLog(@"viewmodel is nil");
        return nil;
   
    }

}
- (void)removeTrial{
    
}
- (void)layOutMainScrollSubviews{
    for (int i = 0; i < _viewModel.imageArray.count; i++) {
        NSString * titleContent = _viewModel.titleArray[i];
        CGFloat fontNumbe = 15;

        UIFont *font =  [UIFont systemFontOfSize:fontNumbe];
        CGSize labelsize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) tilte:titleContent font:font];
        
        UIView *scrollView = [[UIView alloc]initWithFrame:CGRectMake(i*_mainScrollView.frame.size.width, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        
        UIImageView *scrollImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        scrollImageView.image = [UIImage imageNamed:_viewModel.imageArray[i]];
        
        UIView *labelBackView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(scrollImageView.frame)-10-(labelsize.width+10), CGRectGetMaxY(scrollImageView.frame)-20-30, labelsize.width+10, 30)];
        labelBackView.backgroundColor = HexRGB(KTilteLabelBackGround);
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5,labelsize.width,labelsize.height)];
        title.font = font;
        title.textColor = [UIColor whiteColor];
        title.text = titleContent;
        title.numberOfLines = 1;
        
        [labelBackView addSubview:title];
        [scrollView  addSubview:scrollImageView];
        [scrollView  addSubview:labelBackView];
        [_mainScrollView addSubview:scrollView ];
        
    }
}
#pragma mark Reset 
- (CGSize)boundingRectWithSize:(CGSize)size tilte:(NSString *)title font:(UIFont *)font{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect =  [title boundingRectWithSize:size options:options attributes:attributes context:nil];
    return rect.size;
}

@end

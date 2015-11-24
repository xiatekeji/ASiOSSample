//
//  ASBookEditViewController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "ASBookEditViewController.h"

#import "ASNavigator.h"
#import "ASTickerView.h"
#import "ModalCenterReform.h"
#import "ASOptionsView.h"
@interface ASBookEditViewController ()
@property (strong, nonatomic)  ASOptionsView *optionView;
@end
@interface ASBookEditViewController()<ASTickerViewDelegate> {
	ASTickerView* _tickerView;
	NSInteger _currentPageIndex;
}

@end

#pragma mark -

@implementation ASBookEditViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    self.viewModel = [[ASBookEditViewModel alloc]init];
    self.optionView = [[ASOptionsView alloc]initWithOptionViewModel:self.viewModel.options frame:CGRectMake(0, self.view.frame.size.width, self.view.frame.size.height,self.view.frame.size.width/2-30 )];
	UIView* rootView = [super view];
	CGRect rootBounds = [rootView bounds];
	
	UIButton* backButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 20, 40, 20)];
	[backButton addTarget: self action: @selector(goBack) forControlEvents: UIControlEventTouchUpInside];
	[backButton setTitle: @"Back" forState: UIControlStateNormal];
	[backButton setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
	[rootView addSubview: backButton];
	
	ASTickerView* tickerView = [[ASTickerView alloc] initWithFrame: UIEdgeInsetsInsetRect(rootBounds, UIEdgeInsetsMake(60, 20, 20, 20))];
	[tickerView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[tickerView setDelegate: self];
	[tickerView setDuration: 0.2];
	[rootView addSubview: tickerView];
	_tickerView = tickerView;
	
	[tickerView setFrontView: [self viewForPageIndex: 0]];
    
    UIButton *size = [UIButton buttonWithType:UIButtonTypeCustom];
    size.frame = CGRectMake(300, 300, 50, 50);
    [size addTarget:self action:@selector(size:) forControlEvents:UIControlEventTouchUpInside];
    [size setTitle:@"Size" forState:UIControlStateNormal];
    [size setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:size];
    
    UIButton *color = [UIButton buttonWithType:UIButtonTypeCustom];
    color.frame = CGRectMake(0, 300, 50, 50);
    [color addTarget:self action:@selector(color:) forControlEvents:UIControlEventTouchUpInside];
    [color setTitle:@"Color" forState:UIControlStateNormal];
    [color setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:color];
    
    
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    cover.frame = CGRectMake(570, 300, 50, 50);
    [cover addTarget:self action:@selector(cover:) forControlEvents:UIControlEventTouchUpInside];
    [cover setTitle:@"Cover" forState:UIControlStateNormal];
    [cover setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:cover];
    [self.view addSubview:self.optionView];
}
- (void)size:(id)sender {
    [self.optionView selectOptionWithType:ASSizeOption];
}
- (void)color:(id)sender {
    [self.optionView selectOptionWithType:ASColorOption];
}
- (void)cover:(id)sender {
    [self.optionView selectOptionWithType:ASCoverOption];
}
- (void)goBack {
	[[ASNavigator shareModalCenter] dismissCurrentModalViewControlleAnimation:NO completion:^{
        
    }];
}

- (UIView*)viewForPageIndex: (NSInteger)index {
	UIImage* image = [UIImage imageNamed: [[NSString alloc] initWithFormat: @"photos/%d.jpg", (int)index]];
	
	UIImageView* imageView = [[UIImageView alloc] initWithFrame: [_tickerView bounds]];
	[imageView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[imageView setImage: image];
	
	return imageView;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskLandscape;
}

#pragma mark ASNavigatable

- (void)skipPageProtocol: (NSDictionary*)parameters {
	NSString* title = parameters[@"title"];
	[super setTitle: title];
}

#pragma mark ASTickerViewDelegate

- (BOOL)tickerView: (ASTickerView*)tickerView shouldTickWithDirection: (ASTickerViewTickDirection)direction {
	switch(direction) {
		case ASTickerViewTickDirectionLeft:
		{
			return _currentPageIndex < 77;
		}
		
		case ASTickerViewTickDirectionRight:
		{
			return _currentPageIndex > 0;
		}
	}
}

- (void)tickerView: (ASTickerView*)tickerView willTickWithDirection: (ASTickerViewTickDirection)direction {
	NSInteger nextPageIndex = _currentPageIndex;
	switch(direction) {
		case ASTickerViewTickDirectionLeft:
		{
			nextPageIndex++;
			
			break;
		}
		
		case ASTickerViewTickDirectionRight:
		{
			nextPageIndex--;
			
			break;
		}
	}
	
	UIView* view = [self viewForPageIndex: nextPageIndex];
	[tickerView setBackView: view];
	
	_currentPageIndex = nextPageIndex;
}

@end

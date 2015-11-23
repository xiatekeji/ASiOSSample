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

@interface ASBookEditViewController()<ASTickerViewDelegate> {
	ASTickerView* _tickerView;
	NSInteger _currentPageIndex;
}

@end

#pragma mark -

@implementation ASBookEditViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
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
}

- (void)goBack {
	[[ASNavigator shareModalCenter] dismissCurrentModalViewControlleAnimation: TRUE completion: NULL];
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

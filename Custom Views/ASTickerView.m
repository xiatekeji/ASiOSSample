//
//  ASTickerView.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASTickerView.h"

#import <SBTickerView/SBTickerView.h>

@interface ASTickerView() {
	SBTickerView* _enclosedTickerView;
	BOOL _rotated;
}

@end

#pragma mark -

@implementation ASTickerView

- (instancetype)initWithFrame: (CGRect)frame {
	self = [super initWithFrame: frame];
	
	SBTickerView* enclosedTickerView = [[SBTickerView alloc] init];
	[enclosedTickerView setTransform: CGAffineTransformMakeRotation(M_PI_2)];
	[enclosedTickerView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[enclosedTickerView setFrame: [super bounds]];
	[super addSubview: enclosedTickerView];
	_enclosedTickerView = enclosedTickerView;
	
	UISwipeGestureRecognizer* leftSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipe:)];
	[leftSwiper setDirection: UISwipeGestureRecognizerDirectionLeft];
	[super addGestureRecognizer: leftSwiper];
	
	UISwipeGestureRecognizer* rightSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipe:)];
	[rightSwiper setDirection: UISwipeGestureRecognizerDirectionRight];
	[super addGestureRecognizer: rightSwiper];
	
	return self;
}

- (UIView*)frontView {
	return [_enclosedTickerView frontView];
}

- (void)setFrontView: (UIView*)frontView {
	[_enclosedTickerView setFrontView: frontView];
}

- (UIView*)backView {
	return [_enclosedTickerView backView];
}

- (void)setBackView: (UIView*)backView {
	[_enclosedTickerView setBackView: backView];
}

- (CFTimeInterval)duration {
	return [_enclosedTickerView duration];
}

- (void)setDuration: (CFTimeInterval)duration {
	[_enclosedTickerView setDuration: duration];
}

- (void)tick: (ASTickerViewTickDirection)direction animated: (BOOL)animated completion: (void (^)(void))completion {
	id<ASTickerViewDelegate> delegate = _delegate;
	
	BOOL shouldTick = TRUE;
	if([delegate respondsToSelector: @selector(tickerView:shouldTickWithDirection:)]) {
		shouldTick = [delegate tickerView: self shouldTickWithDirection: direction];
	}
	
	if(!shouldTick) {
		return;
	}
	
	if([delegate respondsToSelector: @selector(tickerView:willTickWithDirection:)]) {
		[delegate tickerView: self willTickWithDirection: direction];
	}
	
	SBTickerViewTickDirection translatedDirection = [self translateDirection: direction];
	[_enclosedTickerView tick: translatedDirection animated: animated completion: ^ {
		if([delegate respondsToSelector: @selector(tickerView:didTickWithDirection:)]) {
			[delegate tickerView: self willTickWithDirection: direction];
		}
		
		if(completion != nil) {
			completion();
		}
	}];
}

- (void)handleSwipe: (UISwipeGestureRecognizer*)swiper {
	switch([swiper direction]) {
		case UISwipeGestureRecognizerDirectionLeft:
		{
			[self tick: ASTickerViewTickDirectionLeft animated: TRUE completion: nil];
			
			break;
		}
		
		case UISwipeGestureRecognizerDirectionRight:
		{
			[self tick: ASTickerViewTickDirectionRight animated: TRUE completion: nil];
			
			break;
		}
		
		default:
		{
			// Do nothing.
			
			break;
		}
	}
}

- (SBTickerViewTickDirection)translateDirection: (ASTickerViewTickDirection)direction {
	switch(direction) {
		case ASTickerViewTickDirectionLeft:
		{
			return SBTickerViewTickDirectionDown;
		}
		
		case ASTickerViewTickDirectionRight:
		{
			return SBTickerViewTickDirectionUp;
		}
	}
}

@end

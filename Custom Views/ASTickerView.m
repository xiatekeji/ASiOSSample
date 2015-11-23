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
	
	BOOL _busy;
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

- (void)setFrontView: (UIView*)frontView {
	_frontView = frontView;
	
	UIView* wrapper = [self wrapperForView: frontView];
	[_enclosedTickerView setFrontView: wrapper];
}

- (void)setBackView: (UIView*)backView {
	_backView = backView;
	
	UIView* wrapper = [self wrapperForView: backView];
	[_enclosedTickerView setBackView: wrapper];
}

- (CFTimeInterval)duration {
	return [_enclosedTickerView duration];
}

- (void)setDuration: (CFTimeInterval)duration {
	[_enclosedTickerView setDuration: duration];
}

- (void)tick: (ASTickerViewTickDirection)direction animated: (BOOL)animated completion: (void (^)(void))completion {
	if(_busy) {
		return;
	}
	
	id<ASTickerViewDelegate> delegate = _delegate;
	
	BOOL shouldTick = TRUE;
	if([delegate respondsToSelector: @selector(tickerView:shouldTickWithDirection:)]) {
		shouldTick = [delegate tickerView: self shouldTickWithDirection: direction];
	}
	
	if(!shouldTick) {
		return;
	}
	
	_busy = TRUE;
	
	if([delegate respondsToSelector: @selector(tickerView:willTickWithDirection:)]) {
		[delegate tickerView: self willTickWithDirection: direction];
	}
	
	SBTickerViewTickDirection translatedDirection = [self translateDirection: direction];
	[_enclosedTickerView tick: translatedDirection animated: animated completion: ^ {
		_busy = FALSE;
		
		if([delegate respondsToSelector: @selector(tickerView:didTickWithDirection:)]) {
			[delegate tickerView: self willTickWithDirection: direction];
		}
		
		if(completion != nil) {
			completion();
		}
	}];
}

- (UIView*)wrapperForView: (UIView*)view {
	// 由于SBTickerView在这里被顺时针旋转了90度，交给它的View必须事先逆时针旋转90度才能正确显示。
	// 由于SBTickerView在进行动画时进行了View截图，所以交给它的View不能带有旋转效果。
	
	// 外层的Wrapper不进行旋转，并且保持和SBTickerView尺寸一致。
	UIView* outerWrapper = [[UIView alloc] initWithFrame: [_enclosedTickerView bounds]];
	[outerWrapper setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[outerWrapper setClipsToBounds: TRUE];
	
	// 内层的Wrapper进行逆时针旋转90度，保持和ASTickerView尺寸一致。
	UIView* innerWrapper = [[UIView alloc] init];
	[innerWrapper setTransform: CGAffineTransformMakeRotation(- M_PI_2)];
	[innerWrapper setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[innerWrapper setClipsToBounds: TRUE];
	[innerWrapper setFrame: [outerWrapper bounds]];
	[innerWrapper layoutIfNeeded];
	[outerWrapper addSubview: innerWrapper];
	
	[innerWrapper addSubview: view];
	
	return outerWrapper;
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

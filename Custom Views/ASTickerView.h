//
//  ASTickerView.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ASTickerViewTickDirection) {
	ASTickerViewTickDirectionLeft,
	ASTickerViewTickDirectionRight,
};

@protocol ASTickerViewDelegate;

@interface ASTickerView : UIView

@property(nonatomic, weak, nullable) id<ASTickerViewDelegate> delegate;

@property(nonatomic, strong, nullable) UIView* frontView;
@property(nonatomic, strong, nullable) UIView* backView;

@property(nonatomic, assign) CFTimeInterval duration; // default .5

- (void)tick: (ASTickerViewTickDirection)direction animated: (BOOL)animated completion: (void (^ _Nullable)(void))completion;

@end

#pragma mark -

@protocol ASTickerViewDelegate<NSObject>

@optional

- (BOOL)tickerView: (ASTickerView* _Nonnull)tickerView shouldTickWithDirection: (ASTickerViewTickDirection)direction;

- (void)tickerView: (ASTickerView* _Nonnull)tickerView willTickWithDirection:(ASTickerViewTickDirection)direction;
- (void)tickerView: (ASTickerView* _Nonnull)tickerView didTickWithDirection:(ASTickerViewTickDirection)direction;

@end
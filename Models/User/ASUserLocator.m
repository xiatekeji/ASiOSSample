//
//  ASUserLocator.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/19.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASUserLocator.h"

@implementation ASUserLocator

static ASUserLocator* _sharedInstance = nil;

+ (instancetype _Nonnull)sharedInstance {
	if(_sharedInstance == nil) {
		@synchronized([self class]) {
			if(_sharedInstance == nil) {
				_sharedInstance = [[super alloc] init];
			}
		}
	}
	
	return _sharedInstance;
}

@end

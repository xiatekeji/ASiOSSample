//
//  ASSignOutCommand.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASSignOutCommand.h"

#import "ASSignOutEvent.h"
#import "ASSignOutSuccessEvent.h"
#import "ASSignOutFailureEvent.h"
#import "ASUserLocator.h"
#import "XEBEventBus.h"

@implementation ASSignOutCommand

static NSInteger _invocationCount = 0;

- (void)executeWithEvent: (id)event {
	if([event isKindOfClass: [ASSignOutEvent class]]) {
		[self doSignOut];
	}
	else {
		[super executeWithEvent: event];
	}
}

- (void)doSignOut {
	dispatch_queue_t backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
	dispatch_async(backgroundQueue, ^ {
		// 模拟网络连接耗时。
		
		[NSThread sleepForTimeInterval: 1];
		
		// 模拟请求成功获失败。
		
		NSInteger invocationCount;
		@synchronized([self class]) {
			_invocationCount++;
			invocationCount = _invocationCount;
		}
		
		if((invocationCount % 2) == 0) {
			[self signOutSucceeded];
		}
		else {
			[self signOutFailedWithError: nil];
		}
	});
}

- (void)signOutSucceeded {
	ASUserLocator* userLocator = [ASUserLocator sharedInstance];
	[userLocator setUser: nil];
	
	ASSignOutSuccessEvent* successEvent = [[ASSignOutSuccessEvent alloc] init];
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus postEvent: successEvent];
}

- (void)signOutFailedWithError: (NSError*)error {
	ASSignOutFailureEvent* failureEvent = [[ASSignOutFailureEvent alloc] init];
	[failureEvent setError: error];
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus postEvent: failureEvent];
}

@end

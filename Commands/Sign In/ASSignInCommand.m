//
//  ASDoSignInCommand.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASSignInCommand.h"

#import "ASNavigator.h"
#import "ASSignInEvent.h"
#import "ASSignInSuccessEvent.h"
#import "ASSignInFailureEvent.h"
#import "ASUser.h"
#import "ASUserLocator.h"
#import "XEBEventBus.h"

@implementation ASSignInCommand

static NSInteger _invocationCount = 0;

- (void)executeWithEvent: (id)event {
	if([event isKindOfClass: [ASSignInEvent class]]) {
		NSString* account = [event account];
		NSString* password = [event password];
		[self doSignInWithAccount: account password: password];
	}
	else {
		[super executeWithEvent: event];
	}
}

- (void)doSignInWithAccount: (NSString*)account password: (NSString*)password {
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
			ASUser* user = [[ASUser alloc] init];
			[user setAccount: account];
			
			[self signInSucceededWithUser: user];
		}
		else {
			[self signInFailedWithError: nil];
		}
	});
}

- (void)signInSucceededWithUser: (ASUser*)user {
	ASUserLocator* userLocator = [ASUserLocator sharedInstance];
	[userLocator setUser: user];
	
	ASSignInSuccessEvent* successEvent = [[ASSignInSuccessEvent alloc] init];
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus postEvent: successEvent];
}

- (void)signInFailedWithError: (NSError*)error {
	ASSignInFailureEvent* failureEvent = [[ASSignInFailureEvent alloc] init];
	[failureEvent setError: error];
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus postEvent: failureEvent];
}

@end

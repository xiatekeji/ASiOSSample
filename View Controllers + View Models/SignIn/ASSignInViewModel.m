//
//  ASSignInViewModel.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASSignInViewModel.h"

#import <MBProgressHUD/MBProgressHUD.h>
#import "ASSignInEvent.h"
#import "ASSignInFailureEvent.h"
#import "ASSignInSuccessEvent.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"

@interface ASSignInViewModel()<XEBSubscriber> {
	XEBEventBus* _eventBus;
}

@property(nonatomic) BOOL inProgress;
@property(nonatomic, copy, nullable) NSString* progressMessage;

@property(nonatomic, copy, nullable) NSString* alertMessage;

@property(nonatomic) BOOL completed;

@end

#pragma mark -

@implementation ASSignInViewModel

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[ASSignInSuccessEvent class],
		[ASSignInFailureEvent class]
	];
}

- (instancetype)init {
	self = [super init];
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus registerSubscriber: self];
	_eventBus = eventBus;
	
	return self;
}

- (void)dealloc {
	[_eventBus unregisterSubscriber: self];
}

- (void)doSignIn {
	ASSignInEvent* signInEvent = [[ASSignInEvent alloc] init];
	signInEvent.account = _account;
	signInEvent.password = _password;
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus postEvent: signInEvent];
	
	[self setInProgress: TRUE];
	[self setProgressMessage: @"Please wait..."];
}

- (void)handleSignInSuccessEvent: (ASSignInSuccessEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
	
	[self setCompleted: TRUE];
}

- (void)handleSignInFailureEvent: (ASSignInFailureEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
	
	[self setAlertMessage: @"Failed to sign in."];
}

#pragma mark XEBSubscriber

- (void)onEventMainThread: (id)event {
	if([event isKindOfClass: [ASSignInSuccessEvent class]]) {
		[self handleSignInSuccessEvent: event];
		
		return;
	}
	
	if([event isKindOfClass: [ASSignInFailureEvent class]]) {
		[self handleSignInFailureEvent: event];
		
		return;
	}
}

@end

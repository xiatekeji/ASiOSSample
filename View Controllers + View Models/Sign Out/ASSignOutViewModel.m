//
//  ASSignOutViewModel.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASSignOutViewModel.h"

#import "ASSignOutEvent.h"
#import "ASSignOutFailureEvent.h"
#import "ASSignOutSuccessEvent.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"

@interface ASSignOutViewModel()<XEBSubscriber> {
	XEBEventBus* _eventBus;
}

@property(nonatomic) BOOL inProgress;
@property(nonatomic, copy, nullable) NSString* progressMessage;

@end

#pragma mark -

@implementation ASSignOutViewModel

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[ASSignOutSuccessEvent class],
		[ASSignOutFailureEvent class]
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

- (void)doSignOut {
	ASSignOutEvent* signOutEvent = [[ASSignOutEvent alloc] init];
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus postEvent: signOutEvent];
	
	[self setInProgress: TRUE];
	[self setProgressMessage: @"Please wait..."];
}

- (void)handleSignOutSuccessEvent: (ASSignOutSuccessEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
}

- (void)handleSignOutFailureEvent: (ASSignOutFailureEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
}

#pragma mark XEBSubscriber

- (void)onEvent: (id)event {
	if([event isKindOfClass: [ASSignOutSuccessEvent class]]) {
		[self handleSignOutSuccessEvent: event];
		
		return;
	}
	
	if([event isKindOfClass: [ASSignOutFailureEvent class]]) {
		[self handleSignOutFailureEvent: event];
		
		return;
	}
}

@end

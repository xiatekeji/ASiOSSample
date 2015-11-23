//
//  ASBaseViewModel.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASBaseViewModel.h"

@import ObjectiveC;

#import "ASCommandEvent.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"

@interface ASBaseViewModel()<XEBSubscriber> {
	XEBEventBus* _eventBus;
}

@end

#pragma mark -

@implementation ASBaseViewModel

+ (NSArray<Class>*)handleableEventClasses {
	NSMutableArray<Class>* classes = [[NSMutableArray alloc] init];
	
	unsigned int methodCount = 0;
	Method* methodPointer = class_copyMethodList(self, &methodCount);
	
	for(int i = 0; i < methodCount; i++) {
		Method method = *(methodPointer + i);
		
		SEL selector = method_getName(method);
		NSString* methodName = NSStringFromSelector(selector);
		
		if([methodName hasPrefix: @"handle"]) {
			NSInteger methodNameLength = [methodName length];
			BOOL methodNameEndsWithColon = [methodName hasSuffix: @":"];
			
			NSRange classNameRange = NSMakeRange(6, methodNameLength - (methodNameEndsWithColon ? 7 : 6));
			NSString* className = [methodName substringWithRange: classNameRange];
			
			Class clazz = NSClassFromString(className);
			if(clazz != nil) {
				[classes addObject: clazz];
			}
		}
	}
	
	free(methodPointer);
	
	// Do nothing.
	// Needs to be overriden in most cases.
	
	return classes;
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

- (void)postEvent: (ASCommandEvent*)event {
	[_eventBus postEvent: event];
}

- (void)onEvent: (id)event {
	NSString* className = NSStringFromClass([event class]);
	
	// Check for method without a tailing colon.
	{
		NSString* methodName = [[NSString alloc] initWithFormat: @"handle%@", className];
		SEL selector = NSSelectorFromString(methodName);
		if([self respondsToSelector: selector]) {
			NSInvocation* invocation = [NSInvocation invocationWithMethodSignature: [self methodSignatureForSelector: selector]];
			[invocation setTarget: self];
			[invocation setSelector: selector];
			[invocation invoke];
		}
	}
	
	// Check for method with a tailing colon.
	{
		NSString* methodName = [[NSString alloc] initWithFormat: @"handle%@:", className];
		SEL selector = NSSelectorFromString(methodName);
		if([self respondsToSelector: selector]) {
			NSInvocation* invocation = [NSInvocation invocationWithMethodSignature: [self methodSignatureForSelector: selector]];
			[invocation setTarget: self];
			[invocation setSelector: selector];
			[invocation setArgument: &event atIndex: 2];
			[invocation retainArguments];
			[invocation invoke];
		}
	}
}

@end

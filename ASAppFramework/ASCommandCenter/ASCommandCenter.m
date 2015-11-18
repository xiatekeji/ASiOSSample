//
//  ASCommandCenter.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 侠特科技. All rights reserved.
//

#import "ASCommandCenter.h"

#import "ASCommand.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"

#define TAG @"command"

#pragma mark -

@interface ASCommandCenter()<XEBSubscriber> {
	XEBEventBus* _eventBus;
	
	NSMutableDictionary<NSString*, Class>* _commandClassByEventClassName;
}

@end

#pragma mark -

@implementation ASCommandCenter

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[NSObject class]
	];
}

static ASCommandCenter* _defaultInstance;

+ (instancetype)defaultCenter {
	if(_defaultInstance == nil) {
		@synchronized([self class]) {
			if(_defaultInstance == nil) {
				_defaultInstance = [[super alloc] init];
			}
		}
	}
	
	return _defaultInstance;
}

- (instancetype)init {
	self = [super init];
	
	// 此处不使用默认的EventBus，以免外部干涉。
	XEBEventBus* eventBus = [[XEBEventBus alloc] init];
	[eventBus register: self];
	_eventBus = eventBus;
	
	_commandClassByEventClassName = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (void)dealloc {
	[_eventBus unregister: self];
}

- (void)bindCommand: (Class)commandClass toEvent: (Class)eventClass {
	NSParameterAssert([commandClass conformsToProtocol: @protocol(ASCommand)]);
	
	NSString* eventClassName = NSStringFromClass(eventClass);
	
	@synchronized(_commandClassByEventClassName) {
		Class boundCommandClass = _commandClassByEventClassName[eventClassName];
		if(boundCommandClass != nil) {
			NSLog(@"[%@]Event class \"%@\" has already been bound with command class \"%@\", so it cannot be bound with command class \"%@\".", TAG, eventClassName, NSStringFromClass(boundCommandClass), NSStringFromClass(commandClass));
			
			return;
		}
		
		_commandClassByEventClassName[eventClassName] = commandClass;
	}
}

- (void)unbindCommandFromEvent: (Class)eventClass {
	NSString* eventClassName = NSStringFromClass(eventClass);
	
	@synchronized(_commandClassByEventClassName) {
		if(_commandClassByEventClassName[eventClassName] == nil) {
			NSLog(@"[%@]Event class \"%@\" has not been bound with any command class!", TAG, eventClassName);
			
			return;
		}
		
		_commandClassByEventClassName[eventClassName] = nil;
	}
}

- (void)postEvent: (id)event {
	[_eventBus post: event];
}

- (void)onEvent: (id)event {
	Class eventClass = [event class];
	NSString* eventClassName = NSStringFromClass(eventClass);
	
	Class commandClass;
	@synchronized(_commandClassByEventClassName) {
		commandClass = _commandClassByEventClassName[eventClassName];
	}
	
	if(commandClass == nil) {
		return;
	}
	
	id<ASCommand> command = [[commandClass alloc] init];
	[command executeWithEvent: event];
}

@end

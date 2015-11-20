//
//  ASCommandCenter.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 侠特科技. All rights reserved.
//

#import "ASCommandCenter.h"

#import "ASCommand.h"
#import "ASCommandEvent.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"

#define TAG @"command"

#pragma mark -

@interface ASCommandCenter()<XEBSubscriber> {
	XEBEventBus* _eventBus;
	
	NSMutableDictionary<NSValue*, Class>* _commandClassByEventClass;
}

@end

#pragma mark -

@implementation ASCommandCenter

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[ASCommandEvent class]
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
	return [self initWithEventBus: [XEBEventBus defaultEventBus]];
}

- (instancetype)initWithEventBus: (XEBEventBus*)eventBus {
	self = [super init];
	
	if(eventBus == nil) {
		eventBus = [XEBEventBus defaultEventBus];
	}
	_eventBus = eventBus;
	
	_commandClassByEventClass = [[NSMutableDictionary alloc] init];
	
	[_eventBus registerSubscriber: self];
	
	return self;
}

- (void)dealloc {
	[_eventBus unregisterSubscriber: self];
}

- (void)bindCommand: (Class)commandClass toEvent: (Class)eventClass {
	NSParameterAssert([commandClass conformsToProtocol: @protocol(ASCommand)]);
	NSParameterAssert([eventClass isSubclassOfClass: [ASCommandEvent class]]);
	
	NSValue* eventClassPointer = [NSValue valueWithNonretainedObject: eventClass];
	
	@synchronized(_commandClassByEventClass) {
		Class boundCommandClass = _commandClassByEventClass[eventClassPointer];
		if(boundCommandClass != nil) {
			NSLog(@"[%@]Event class \"%@\" has already been bound with command class \"%@\", so it cannot be bound again with command class \"%@\".", TAG, NSStringFromClass(eventClass), NSStringFromClass(boundCommandClass), NSStringFromClass(commandClass));
			
			return;
		}
		
		_commandClassByEventClass[eventClassPointer] = commandClass;
	}
}

- (void)unbindCommandFromEvent: (Class)eventClass {
	NSValue* eventClassPointer = [NSValue valueWithNonretainedObject: eventClass];
	
	@synchronized(_commandClassByEventClass) {
		if(_commandClassByEventClass[eventClassPointer] == nil) {
			NSLog(@"[%@]Event class \"%@\" has not been bound with any command class, so there is no need to unbind it.", TAG, NSStringFromClass(eventClass));
			
			return;
		}
		
		_commandClassByEventClass[eventClassPointer] = nil;
	}
}

- (void)onEvent: (ASCommandEvent*)event {
	Class eventClass = [event class];
	NSValue* eventClassPointer = [NSValue valueWithNonretainedObject: eventClass];
	
	Class commandClass;
	@synchronized(_commandClassByEventClass) {
		commandClass = _commandClassByEventClass[eventClassPointer];
	}
	
	if(commandClass == nil) {
		NSLog(@"[%@]Event class \"%@\" has not been bound with any command class, so no command will be executed.", TAG, NSStringFromClass(eventClass));
		
		return;
	}
	
	id<ASCommand> command = [[commandClass alloc] init];
	[command executeWithEvent: event];
}

@end

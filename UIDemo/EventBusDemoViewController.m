//
//  EventBusDemoViewController.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/13.
//  Copyright © 2015年 侠特科技. All rights reserved.
//

#define USES_DISTINCT_SUBSCRIBERS TRUE

#if USES_DISTINCT_SUBSCRIBERS

#import "EventBusDemoViewController.h"

#import "XEBEventBus.h"
#import "XEBSubscriber.h"

#define SimpleEvent EventBusDemoViewController_SimpleEvent
#define MessageEvent EventBusDemoViewController_MessageEvent
#define StartEvent EventBusDemoViewController_StartEvent
#define StopEvent EventBusDemoViewController_StopEvent

#define SimpleEventSubscriber EventBusDemoViewController_SimpleEventSubscriber
#define MessageEventSubscriber EventBusDemoViewController_MessageEventSubscriber
#define StartEventSubscriber EventBusDemoViewController_StartEventSubscriber
#define StopEventSubscriber EventBusDemoViewController_StopEventSubscriber

@interface SimpleEvent : NSObject

@end

#pragma mark -

@interface MessageEvent : NSObject

- (instancetype _Nonnull)initWithMessage: (NSString* _Nullable)message NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy, nullable) NSString* message;

@end

#pragma mark -

@interface StartEvent : NSObject

@end

#pragma mark -

@interface StopEvent : NSObject

@end

#pragma mark -

@interface SimpleEventSubscriber : NSObject<XEBSubscriber>

+ (instancetype _Nonnull)alloc __unavailable;
+ (instancetype _Nonnull)allocWithOwner: (EventBusDemoViewController*)owner;

@end

#pragma mark -

@interface MessageEventSubscriber : NSObject<XEBSubscriber>

+ (instancetype _Nonnull)alloc __unavailable;
+ (instancetype _Nonnull)allocWithOwner: (EventBusDemoViewController*)owner;

@end

#pragma mark -

@interface StartEventSubscriber : NSObject<XEBSubscriber>

+ (instancetype _Nonnull)alloc __unavailable;
+ (instancetype _Nonnull)allocWithOwner: (EventBusDemoViewController*)owner;

@end

#pragma mark -

@interface StopEventSubscriber : NSObject<XEBSubscriber>

+ (instancetype _Nonnull)alloc __unavailable;
+ (instancetype _Nonnull)allocWithOwner: (EventBusDemoViewController*)owner;

@end

#pragma mark -

@interface EventBusDemoViewController() {
	XEBEventBus* _eventBus;
	
	SimpleEventSubscriber* _simpleEventSubscriber;
	MessageEventSubscriber* _messageEventSubscriber;
	StartEventSubscriber* _startEventSubscriber;
	StopEventSubscriber* _stopEventSubscriber;
	
	UIAlertController* _alertController;
}

@end

#pragma mark -

@implementation EventBusDemoViewController

- (instancetype)init {
	self = [super init];
	
	_eventBus = [XEBEventBus defaultEventBus];
	
	SimpleEventSubscriber* simpleEventSubscriber = [[SimpleEventSubscriber allocWithOwner: self] init];
	[_eventBus register: simpleEventSubscriber];
	_simpleEventSubscriber = simpleEventSubscriber;
	
	MessageEventSubscriber* messageEventSubscriber = [[MessageEventSubscriber allocWithOwner: self] init];
	[_eventBus register: messageEventSubscriber];
	_messageEventSubscriber = messageEventSubscriber;
	
	StartEventSubscriber* startEventSubscriber = [[StartEventSubscriber allocWithOwner: self] init];
	[_eventBus register: startEventSubscriber];
	_startEventSubscriber = startEventSubscriber;
	
	StopEventSubscriber* stopEventSubscriber = [[StopEventSubscriber allocWithOwner: self] init];
	[_eventBus register: stopEventSubscriber];
	_stopEventSubscriber = stopEventSubscriber;
	
	return self;
}

- (void)dealloc {
	[_eventBus unregister: _simpleEventSubscriber];
	[_eventBus unregister: _messageEventSubscriber];
	[_eventBus unregister: _startEventSubscriber];
	[_eventBus unregister: _stopEventSubscriber];
}

- (IBAction)demonstrateSimpleEvent {
	SimpleEvent* event = [[SimpleEvent alloc] init];
	[_eventBus post: event];
}

- (IBAction)demonstrateEventWithArguments {
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Enter a message:" preferredStyle: UIAlertControllerStyleAlert];
	[alertController addTextFieldWithConfigurationHandler: NULL];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Send" style: UIAlertActionStyleDefault handler: ^(UIAlertAction* action) {
			UITextField* textField = [[alertController textFields] firstObject];
			NSString* message = [textField text];
			
			MessageEvent* messageEvent = [[MessageEvent alloc] initWithMessage: message];
           
			[_eventBus post: messageEvent];
		}
	]];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (IBAction)demonstrateEventOnBackgroundThread {
	StartEvent* event = [[StartEvent alloc] init];
	[_eventBus post: event];
}

- (void)handleSimpleEvent: (SimpleEvent*)simpleEvent {
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Received a simple event." preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)handleMessageEvent: (MessageEvent*)messageEvent {
	[self ensureThatNoAlertControllerIsPresented];
	
	NSString* message = [messageEvent message];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: [[NSString alloc] initWithFormat: @"Received a message:\n%@", message] preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)handleStartEvent: (StartEvent*)startEvent {
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Performing background task..." preferredStyle: UIAlertControllerStyleAlert];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)handleStartEventInBackground: (StartEvent*)startEvent {
	assert(![NSThread isMainThread]);
	
	[NSThread sleepForTimeInterval: 5];
	
	StopEvent* stopEvent = [[StopEvent alloc] init];
	[_eventBus post: stopEvent];
}

- (void)handleStopEvent: (StopEvent*)event {
	assert([NSThread isMainThread]);
	
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Background task finished." preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)ensureThatNoAlertControllerIsPresented {
	if(_alertController != nil) {
		[_alertController dismissViewControllerAnimated: TRUE completion: NULL];
		_alertController = nil;
	}
}

#pragma mark ASModalCenterControllProtocol

- (void)skipPageProtocol:(NSDictionary *)parameters{
    
}

@end

#pragma mark -

@implementation SimpleEvent

@end

#pragma mark -

@implementation MessageEvent

- (instancetype)init {
	return [self initWithMessage: nil];
}

- (instancetype)initWithMessage: (NSString*)message {
	self = [super init];
	
	[self setMessage: message];
	
	return self;
}

@end

#pragma mark -

@implementation StartEvent

@end

#pragma mark -

@implementation StopEvent

@end

#pragma mark -

@interface SimpleEventSubscriber() {
	EventBusDemoViewController* __weak _owner;
}

@end

#pragma mark -

@implementation SimpleEventSubscriber

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[SimpleEvent class]
	];
}

+ (instancetype)allocWithOwner: (EventBusDemoViewController*)owner {
	SimpleEventSubscriber* instance = [super alloc];
	instance->_owner = owner;
	
	return instance;
}

- (void)onEvent: (SimpleEvent*)event {
	[_owner handleSimpleEvent: event];
}

@end

#pragma mark -

@interface MessageEventSubscriber() {
	EventBusDemoViewController* __weak _owner;
}

@end

#pragma mark -

@implementation MessageEventSubscriber

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[MessageEvent class]
	];
}

+ (instancetype)allocWithOwner: (EventBusDemoViewController*)owner {
	MessageEventSubscriber* instance = [super alloc];
	instance->_owner = owner;
	
	return instance;
}

- (void)onEvent: (MessageEvent*)event {
	[_owner handleMessageEvent: event];
}

@end

#pragma mark -

@interface StartEventSubscriber() {
	EventBusDemoViewController* __weak _owner;
}

@end

#pragma mark -

@implementation StartEventSubscriber

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[StartEvent class]
	];
}

+ (instancetype)allocWithOwner: (EventBusDemoViewController*)owner {
	StartEventSubscriber* instance = [super alloc];
	instance->_owner = owner;
	
	return instance;
}

- (void)onEvent: (StartEvent*)event {
	[_owner handleStartEvent: event];
}

- (void)onEventBackgroundThread: (StartEvent*)event {
	[_owner handleStartEventInBackground: event];
}

@end

#pragma mark -

@interface StopEventSubscriber() {
	EventBusDemoViewController* __weak _owner;
}

@end

#pragma mark -

@implementation StopEventSubscriber

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[StopEvent class]
	];
}

+ (instancetype)allocWithOwner: (EventBusDemoViewController*)owner {
	StopEventSubscriber* instance = [super alloc];
	instance->_owner = owner;
	
	return instance;
}

- (void)onEventMainThread: (StopEvent*)event {
	[_owner handleStopEvent: event];
}

@end

#else

#import "EventBusDemoViewController.h"

#import "XEBEventBus.h"
#import "XEBSubscriber.h"

#define SimpleEvent EventBusDemoViewController_SimpleEvent
#define MessageEvent EventBusDemoViewController_MessageEvent
#define StartEvent EventBusDemoViewController_StartEvent
#define StopEvent EventBusDemoViewController_StopEvent

@interface SimpleEvent : NSObject

@end

#pragma mark -

@interface MessageEvent : NSObject

- (instancetype _Nonnull)initWithMessage: (NSString* _Nullable)message NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy, nullable) NSString* message;

@end

#pragma mark -

@interface StartEvent : NSObject

@end

#pragma mark -

@interface StopEvent : NSObject

@end

#pragma mark -

@interface EventBusDemoViewController()<XEBSubscriber> {
	XEBEventBus* _eventBus;
	
	UIAlertController* _alertController;
}

@end

#pragma mark -

@implementation EventBusDemoViewController

+ (NSArray<Class>*)handleableEventClasses {
    
	return @[
		[NSObject class]
	];
}

- (instancetype)init {
	self = [super init];
	
	_eventBus = [XEBEventBus defaultEventBus];
	
	[_eventBus register: self];
	
	return self;
}

- (void)dealloc {
	[_eventBus unregister: self];
}

- (IBAction)demonstrateSimpleEvent {
	SimpleEvent* event = [[SimpleEvent alloc] init];
	[_eventBus post: event];
}

- (IBAction)demonstrateEventWithArguments {
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Enter a message:" preferredStyle: UIAlertControllerStyleAlert];
	[alertController addTextFieldWithConfigurationHandler: NULL];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Send" style: UIAlertActionStyleDefault handler: ^(UIAlertAction* action) {
			UITextField* textField = [[alertController textFields] firstObject];
			NSString* message = [textField text];
			
			MessageEvent* messageEvent = [[MessageEvent alloc] initWithMessage: message];
			[_eventBus post: messageEvent];
		}
	]];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (IBAction)demonstrateEventOnBackgroundThread {
	StartEvent* event = [[StartEvent alloc] init];
	[_eventBus post: event];
}

- (void)onEvent: (id)event {
	if([event isKindOfClass: [SimpleEvent class]]) {
		[self handleSimpleEvent: event];
	}
	
	if([event isKindOfClass: [MessageEvent class]]) {
		[self handleMessageEvent: event];
	}
	
	if([event isKindOfClass: [StartEvent class]]) {
		[self handleStartEvent: event];
	}
}

- (void)onEventMainThread: (id)event {
	if([event isKindOfClass: [StopEvent class]]) {
		[self handleStopEvent: event];
	}
}

- (void)onEventBackgroundThread: (id)event {
	if([event isKindOfClass: [StartEvent class]]) {
		[self handleStartEventInBackground: event];
	}
}

- (void)handleSimpleEvent: (SimpleEvent*)simpleEvent {
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Received a simple event." preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)handleMessageEvent: (MessageEvent *)messageEvent {
	[self ensureThatNoAlertControllerIsPresented];
    NSLog(@"message Super Class = %@",NSStringFromClass(messageEvent.superclass));
	NSString* message = [messageEvent message];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: [[NSString alloc] initWithFormat: @"Received a message:\n%@", message] preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)handleStartEvent: (StartEvent*)startEvent {
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Performing background task..." preferredStyle: UIAlertControllerStyleAlert];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)handleStartEventInBackground: (StartEvent*)startEvent {
	assert(![NSThread isMainThread]);
	
	[NSThread sleepForTimeInterval: 5];
	
	StopEvent* stopEvent = [[StopEvent alloc] init];
	[_eventBus post: stopEvent];
}

- (void)handleStopEvent: (StopEvent*)event {
	assert([NSThread isMainThread]);
	
	[self ensureThatNoAlertControllerIsPresented];
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Background task finished." preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction: [
		UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: ^(UIAlertAction* action) {
			if(_alertController == alertController) {
				_alertController = nil;
			}
		}
	]];
	[self presentViewController: alertController animated: TRUE completion: NULL];
	_alertController = alertController;
}

- (void)ensureThatNoAlertControllerIsPresented {
	if(_alertController != nil) {
		[_alertController dismissViewControllerAnimated: TRUE completion: NULL];
		_alertController = nil;
	}
}

#pragma mark ASModalCenterControllProtocol

- (void)skipPageProtocol:(NSDictionary *)parameters {
	// Do nothing.
}

@end

#pragma mark -

@implementation SimpleEvent

@end

#pragma mark -

@implementation MessageEvent

- (instancetype)init {
	return [self initWithMessage: nil];
}

- (instancetype)initWithMessage: (NSString*)message {
	self = [super init];
	
	[self setMessage: message];
	
	return self;
}

@end

#pragma mark -

@implementation StartEvent

@end

#pragma mark -

@implementation StopEvent

@end

#endif

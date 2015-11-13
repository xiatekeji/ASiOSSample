/*
 * Copyright (C) 2015 Fu Liye, Xiatekeji (http://www.xiatekeji.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "XEBThreadMode.h"

@interface XEBThreadMode() {
	NSString* _name;
}

- (instancetype)init __unavailable;

@end

#pragma mark -

@implementation XEBThreadMode

XEBThreadMode* XEBThreadModePostThread;
XEBThreadMode* XEBThreadModeMainThread;
XEBThreadMode* XEBThreadModeBackgroundThread;
XEBThreadMode* XEBThreadModeAsync;

NSArray<XEBThreadMode*>* _values;

+ (void)load {
	XEBThreadModePostThread = [[super alloc] initWithName: @"PostThread"];
	XEBThreadModeMainThread = [[super alloc] initWithName: @"MainThread"];
	XEBThreadModeBackgroundThread = [[super alloc] initWithName: @"BackgroundThread"];
	XEBThreadModeAsync = [[super alloc] initWithName: @"Async"];
	
	_values = @[
		XEBThreadModePostThread,
		XEBThreadModeMainThread,
		XEBThreadModeBackgroundThread,
		XEBThreadModeAsync
	];
}

+ (NSArray<XEBThreadMode*>*)values {
	return _values;
}

- (instancetype)initWithName: (NSString*)name {
	self = [super init];
	
	_name = name;
	
	return self;
}

@end

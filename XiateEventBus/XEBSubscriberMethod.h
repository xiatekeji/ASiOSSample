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

#import <Foundation/Foundation.h>

@class XEBThreadMode;
@protocol XEBSubscriber;

@interface XEBSubscriberMethod : NSObject

- (instancetype _Nonnull)initWithSubscriberClass: (Class<XEBSubscriber> _Nonnull)subscriberClass selector: (SEL _Nonnull)selector threadMode: (XEBThreadMode* _Nonnull)threadMode eventClass: (Class _Nonnull)eventClass;

@property(nonatomic, readonly, nonnull) Class<XEBSubscriber> subscriberClass;
@property(nonatomic, readonly, nonnull) SEL selector;
@property(nonatomic, readonly, nonnull) XEBThreadMode* threadMode;
@property(nonatomic, readonly, nonnull) Class eventClass;

@end
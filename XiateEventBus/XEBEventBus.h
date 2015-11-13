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

@protocol XEBSubscriber;

@interface XEBEventBus : NSObject

/**
 * @brief Convenience singleton for apps using a process-wide XEBEventBus instance.
 */
+ (instancetype _Nonnull)defaultEventBus;

- (void)register: (NSObject<XEBSubscriber>* _Nonnull)subscriber;

- (void)register: (NSObject<XEBSubscriber>* _Nonnull)subscriber priority: (NSInteger)priority;

- (void)registerSticky: (NSObject<XEBSubscriber>* _Nonnull)subscriber;

- (void)registerSticky: (NSObject<XEBSubscriber>* _Nonnull)subscriber priority: (NSInteger)priority;

- (BOOL)isRegistered: (NSObject<XEBSubscriber>* _Nonnull)subscriber;

/**
 * @brief Unregisters the given subscriber from all event classes.
 */
- (void)unregister: (NSObject<XEBSubscriber>* _Nonnull)subscriber;

- (BOOL)hasSubscriberForEventClass: (Class _Nonnull)eventClass;

/**
 * @brief Posts the given event to the event bus.
 */
- (void)post: (NSObject* _Nonnull)event;

- (void)cancelEventDelivery: (NSObject* _Nonnull)event;

- (void)postSticky: (NSObject* _Nonnull)event;

@end


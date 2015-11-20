//
//  ASCommandCenter.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 侠特科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XEBEventBus;

@interface ASCommandCenter : NSObject

+ (instancetype _Nonnull)defaultCenter;

- (instancetype _Nonnull)initWithEventBus: (XEBEventBus* _Nullable)eventBus NS_DESIGNATED_INITIALIZER;

- (void)bindCommand: (Class _Nonnull)commandClass toEvent: (Class _Nonnull)eventClass;
- (void)unbindCommandFromEvent: (Class _Nonnull)eventClass;

@end

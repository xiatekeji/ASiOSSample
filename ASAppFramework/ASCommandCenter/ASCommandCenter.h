//
//  ASCommandCenter.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 侠特科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCommandCenter : NSObject

+ (instancetype _Nonnull)defaultCenter;

- (void)bindCommand: (Class _Nonnull)commandClass toEvent: (Class _Nonnull)eventClass;
- (void)unbindCommandFromEvent: (Class _Nonnull)eventClass;

- (void)postEvent: (id _Nonnull)event;

@end

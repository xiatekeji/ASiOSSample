//
//  ASUserLocator.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/19.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASUser;

@interface ASUserLocator : NSObject

+ (instancetype _Nonnull)alloc __unavailable;
+ (instancetype _Nonnull)sharedInstance;

@property(nonatomic, strong, nullable) ASUser* user;

@end

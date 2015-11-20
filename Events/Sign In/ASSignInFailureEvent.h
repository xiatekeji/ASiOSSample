//
//  ASSignInFailureEvent.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSignInFailureEvent : NSObject

@property(nonatomic, strong, nonnull) NSError* error;

@end

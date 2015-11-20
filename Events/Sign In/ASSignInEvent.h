//
//  ASSignInEvent.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASCommandEvent.h"

@interface ASSignInEvent : ASCommandEvent

@property(nonatomic, copy, nonnull) NSString* account;
@property(nonatomic, copy, nonnull) NSString* password;

@end

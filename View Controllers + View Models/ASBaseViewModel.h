//
//  ASBaseViewModel.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCommandEvent;

@interface ASBaseViewModel : NSObject

- (void)postEvent: (ASCommandEvent* _Nonnull)event;

@end

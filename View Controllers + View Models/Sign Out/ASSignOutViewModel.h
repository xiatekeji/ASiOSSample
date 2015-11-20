//
//  ASSignOutViewModel.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSignOutViewModel : NSObject

@property(nonatomic, readonly) BOOL inProgress;
@property(nonatomic, copy, readonly, nullable) NSString* progressMessage;

- (void)doSignOut;

@end

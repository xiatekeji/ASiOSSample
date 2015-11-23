//
//  ASSignInViewModel.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASBaseViewModel.h"

@interface ASSignInViewModel : ASBaseViewModel

@property(nonatomic, copy, nullable) NSString* account;
@property(nonatomic, copy, nullable) NSString* password;

@property(nonatomic, readonly) BOOL inProgress;
@property(nonatomic, copy, readonly, nullable) NSString* progressMessage;

@property(nonatomic, copy, readonly, nullable) NSString* alertMessage;

@property(nonatomic, readonly) BOOL completed;

- (void)doSignIn;

@end

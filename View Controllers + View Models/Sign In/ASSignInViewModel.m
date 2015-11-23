//
//  ASSignInViewModel.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASSignInViewModel.h"

#import "ASSignInEvent.h"
#import "ASSignInFailureEvent.h"
#import "ASSignInSuccessEvent.h"

@interface ASSignInViewModel()

@property(nonatomic) BOOL inProgress;
@property(nonatomic, copy, nullable) NSString* progressMessage;

@property(nonatomic, copy, nullable) NSString* alertMessage;

@property(nonatomic) BOOL completed;

@end

#pragma mark -

@implementation ASSignInViewModel

- (void)doSignIn {
	ASSignInEvent* signInEvent = [[ASSignInEvent alloc] init];
	signInEvent.account = _account;
	signInEvent.password = _password;
	[super postEvent: signInEvent];
	
	[self setInProgress: TRUE];
	[self setProgressMessage: @"Please wait..."];
}

- (void)handleASSignInSuccessEvent: (ASSignInSuccessEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
	
	[self setCompleted: TRUE];
}

- (void)handleASSignInFailureEvent: (ASSignInFailureEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
	
	[self setAlertMessage: @"Failed to sign in."];
}

@end

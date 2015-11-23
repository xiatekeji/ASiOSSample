//
//  ASSignOutViewModel.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/20.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASSignOutViewModel.h"

#import "ASSignOutEvent.h"
#import "ASSignOutFailureEvent.h"
#import "ASSignOutSuccessEvent.h"

@interface ASSignOutViewModel()

@property(nonatomic) BOOL inProgress;
@property(nonatomic, copy, nullable) NSString* progressMessage;

@end

#pragma mark -

@implementation ASSignOutViewModel

- (void)doSignOut {
	ASSignOutEvent* signOutEvent = [[ASSignOutEvent alloc] init];
	[super postEvent: signOutEvent];
	
	[self setInProgress: TRUE];
	[self setProgressMessage: @"Please wait..."];
}

- (void)handleSignOutSuccessEvent: (ASSignOutSuccessEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
}

- (void)handleSignOutFailureEvent: (ASSignOutFailureEvent*)event {
	[self setInProgress: FALSE];
	[self setProgressMessage: nil];
}

@end

//
//  ASSignInViewController.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/15.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//


#import "ASSignInViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>
#import "ASNavigator.h"
#import "ASSignInEvent.h"
#import "ASSignInFailureEvent.h"
#import "ASSignInSuccessEvent.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"


@interface ASSignInViewController()<XEBSubscriber> {
	IBOutlet UITextField* _accountField;
	IBOutlet UITextField* _passwordField;
	IBOutlet UIButton* _signInButton;
	IBOutlet UIButton* _cancelButton;
	
	XEBEventBus* _eventBus;
	
	MBProgressHUD* _progressHud;
}

@end

#pragma mark -

@implementation ASSignInViewController

+ (NSArray<Class>*)handleableEventClasses {
	return @[
		[ASSignInSuccessEvent class],
		[ASSignInFailureEvent class]
	];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus registerSubscriber: self];
	_eventBus = eventBus;
}

- (void)dealloc {
	[_eventBus unregisterSubscriber: self];
}

- (IBAction)handleButton: (UIButton*)button {
	if(button == _signInButton) {
		[self doSignIn];
		
		return;
	}
}

- (void)doSignIn {
	NSString* account = [_accountField text];
	NSString* password = [_passwordField text];
	
	ASSignInEvent* signInEvent = [[ASSignInEvent alloc] init];
	signInEvent.account = account;
	signInEvent.password = password;
	
	XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
	[eventBus postEvent: signInEvent];
	
	MBProgressHUD* progressHud = [MBProgressHUD showHUDAddedTo: [[UIApplication sharedApplication] keyWindow] animated: TRUE];
	[progressHud setLabelText: @"Please wait..."];
	_progressHud = progressHud;
}

- (void)handleSignInSuccessEvent: (ASSignInSuccessEvent*)event {
	[_progressHud removeFromSuperview];
	_progressHud = nil;
	
	[[ASNavigator shareModalCenter] dismissCurrentModalViewControlleAnimation: TRUE completion: NULL];
}

- (void)handleSignInFailureEvent: (ASSignInFailureEvent*)event {
	[_progressHud removeFromSuperview];
	_progressHud = nil;
	
	UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: @"Sign in failed." preferredStyle: UIAlertControllerStyleAlert];
	[alertController addAction: [UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: NULL]];
	[super presentViewController: alertController animated: TRUE completion: NULL];
}

#pragma mark ASNavigatable

- (void)skipPageProtocol: (NSDictionary*)parameters{
	
}

#pragma mark XEBSubscriber

- (void)onEventMainThread: (id)event {
	if([event isKindOfClass: [ASSignInSuccessEvent class]]) {
		[self handleSignInSuccessEvent: event];
		
		return;
	}
	
	if([event isKindOfClass: [ASSignInFailureEvent class]]) {
		[self handleSignInFailureEvent: event];
		
		return;
	}
}

@end


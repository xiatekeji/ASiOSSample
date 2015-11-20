//
//  ASSignInViewController.m
//  PhotoBook
//
//  Created by XiaoSong on 15/9/15.
//  Copyright (c) 2015年 侠特科技. All rights reserved.
//


#import "ASSignInViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ASNavigator.h"
#import "ASSignInViewModel.h"

@interface ASSignInViewController() {
	IBOutlet UITextField* _accountField;
	IBOutlet UITextField* _passwordField;
	IBOutlet UIButton* _signInButton;
	IBOutlet UIButton* _cancelButton;
	
	ASSignInViewModel* _viewModel;
	
	MBProgressHUD* _progressHud;
}

@end

#pragma mark -

@implementation ASSignInViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self bindWithViewModel];
}

#pragma mark View Model

- (void)bindWithViewModel {
	if(_viewModel == nil) {
		_viewModel = [[ASSignInViewModel alloc] init];
	}
	
	RAC(self, viewModel.account) = [_accountField rac_textSignal];
	RAC(self, viewModel.password) = [_passwordField rac_textSignal];
	
	[self displayOrHideProgressHudInTheFuture];
	[self setProgressMessageInTheFuture];
	[self showAlertWithMessageInTheFuture];
	[self dismissInTheFuture];
}

- (void)displayOrHideProgressHudInTheFuture {
	@weakify(self)
	
	[
		[RACObserve(self, viewModel.inProgress) deliverOn: [RACScheduler mainThreadScheduler]]
		subscribeNext: ^(id x) {
			@strongify(self)
			
			BOOL inProgress = [x boolValue];
			if(inProgress) {
				UIView* container = [[UIApplication sharedApplication] keyWindow];
				
				MBProgressHUD* progressHud = [MBProgressHUD showHUDAddedTo: container animated: TRUE];
				[progressHud setRemoveFromSuperViewOnHide: TRUE];
				self->_progressHud = progressHud;
			}
			else {
				[self->_progressHud hide: TRUE];
				self->_progressHud = nil;
			}
		}
	];
}

- (void)setProgressMessageInTheFuture {
	@weakify(self)
	
	[
		[RACObserve(self, viewModel.progressMessage) deliverOn: [RACScheduler mainThreadScheduler]]
		subscribeNext: ^(id x) {
			@strongify(self)
			
			NSString* progressMessage = x;
			[self->_progressHud setLabelText: progressMessage];
		}
	];
}

- (void)showAlertWithMessageInTheFuture {
	@weakify(self)
	
	[
		[RACObserve(self, viewModel.alertMessage) deliverOn: [RACScheduler mainThreadScheduler]]
		subscribeNext: ^(id x) {
			@strongify(self)
			
			NSString* progressMessage = x;
			if(progressMessage != nil) {
				UIAlertController* alertController = [UIAlertController alertControllerWithTitle: nil message: progressMessage preferredStyle: UIAlertControllerStyleAlert];
				
				UIAlertAction* closeAction = [UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleCancel handler: NULL];
				[alertController addAction: closeAction];
				
				[self presentViewController: alertController animated: TRUE completion: NULL];
			}
		}
	];
}

- (void)dismissInTheFuture {
	[
		[RACObserve(self, viewModel.completed) deliverOn: [RACScheduler mainThreadScheduler]]
		subscribeNext: ^(id x) {
			BOOL completed = [x boolValue];
			if(completed) {
				[[ASNavigator shareModalCenter] dismissCurrentModalViewControlleAnimation: TRUE completion: NULL];
			}
		}
	];
}

#pragma mark Action

- (IBAction)handleButton: (UIButton*)button {
	if(button == _signInButton) {
		[_viewModel doSignIn];
		
		return;
	}
	
	if(button == _cancelButton) {
		[[ASNavigator shareModalCenter] dismissCurrentModalViewControlleAnimation: TRUE completion: nil];
		
		return;
	}
}

#pragma mark ASNavigatable

- (void)skipPageProtocol: (NSDictionary*)parameters{
	
}

@end


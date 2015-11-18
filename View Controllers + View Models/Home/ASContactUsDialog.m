//
//  ASContactUsDialog.m
//  Artisan State
//
//  Created by 傅立业 on 15/9/9.
//  Copyright (c) 2015年 侠特科技 . All rights reserved.
//

#import "ASContactUsDialog.h"


#import <Masonry/Masonry.h>


#define WIDTH (CGFloat)320
#define HEIGHT (CGFloat)300

@interface ASContactUsDialog()<UITextFieldDelegate, UITextViewDelegate> {
	ASContactUsDialog* _strongSelf;
	
	UIView* _maskView;
	
	UIView* _dialogView;
	UITextView* _textView1;
	UITextView* _textView2;
	UITextView* _textView3;
	UITextField* _emailTextField;
	UIButton* _doneButton;
	
	CGRect _originalDialogFrame;
	BOOL _flag;
}

- (void)addSubview: (UIView*)subview;

@end

#pragma mark -

@implementation ASContactUsDialog

-(instancetype)init {
	self = [super init];
	if(self != nil) {
		[self buildViewHierachy];
        
	}
	
	return self;
}

// Pretending to be a UIView.
- (void)addSubview: (UIView*)subview {
	[_dialogView addSubview: subview];
}

- (void)buildViewHierachy {
	UIView* maskView = [[UIView alloc] init];
	[maskView setBackgroundColor: [UIColor colorWithWhite: 0 alpha: 0.3]];
	_maskView = maskView;

	UIView* dialogView = [[UIView alloc] init];
	dialogView.backgroundColor = [UIColor blackColor];
	dialogView.layer.cornerRadius = 6;
	dialogView.layer.masksToBounds = YES;
	_dialogView = dialogView;

	UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
	bgView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:0.9];
	[self addSubview:bgView];
	
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
	title.text = @"Contact Us";
	title.textColor = [UIColor blackColor];
	title.font = [UIFont systemFontOfSize:14];
	[self addSubview:title];
	
	UILabel *question = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 200, 20)];
	question.text = @"Have a question?";
	question.textColor = [UIColor blackColor];
	question.font = [UIFont systemFontOfSize:12];
	[self addSubview:question];

	_textView1 = [[UITextView alloc] initWithFrame:CGRectMake(10, 46, 300, 40)];
	_textView1.tag = 0;
	_textView1.delegate = self;
	_textView1.backgroundColor = [UIColor whiteColor];
	[self addSubview:_textView1];
	
	
	UILabel *feature = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 20)];
	feature.text = @"Have a feature request?";
	feature.textColor = [UIColor blackColor];
	feature.font = [UIFont systemFontOfSize:12];
	[self addSubview:feature];
	
	_textView2 = [[UITextView alloc] initWithFrame:CGRectMake(10, 110, 300, 40)];
	_textView2.tag = 1;
	_textView2.delegate = self;
	_textView2.backgroundColor = [UIColor whiteColor];
	[self addSubview:_textView2];
	
	UILabel *bug = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, 200, 20)];
	bug.text = @"Want to report a bug";
	bug.textColor = [UIColor blackColor];
	bug.font = [UIFont systemFontOfSize:12];
	[self addSubview:bug];
	
	_textView3 = [[UITextView alloc] initWithFrame:CGRectMake(10, 179, 300, 40)];
	_textView3.tag = 2;
	_textView3.delegate = self;
	_textView3.backgroundColor = [UIColor whiteColor];
	[self addSubview:_textView3];
	
	UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 70, 20)];
	emailLabel.text = @"Your Email";
	emailLabel.textColor = [UIColor blackColor];
	emailLabel.font = [UIFont systemFontOfSize:12];
	[self addSubview:emailLabel];
	
	
	UILabel *starLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 233, 30, 20)];
	starLabel.text = @"*";
	starLabel.textColor = [UIColor redColor];
	starLabel.font = [UIFont systemFontOfSize:16];
	[self addSubview:starLabel];
	
	
	_emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 230, 200, 20)];
	_emailTextField.delegate = self;
	_emailTextField.font = [UIFont systemFontOfSize:12];
	_emailTextField.textAlignment = NSTextAlignmentCenter;
	_emailTextField.backgroundColor = [UIColor whiteColor];
	[self addSubview:_emailTextField];
	
	UIImageView *imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHT - 35, WIDTH, 0.5)];
	imageLine.backgroundColor = [UIColor grayColor];
	[self addSubview:imageLine];
	
	UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, HEIGHT - 35, 159, 35)];
	cancelBtn.tag = 0;
	[cancelBtn setTitle:@"Cancel" forState: UIControlStateNormal];
	[cancelBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:91/255.0 blue:249/255.0 alpha:1.0] forState:UIControlStateNormal];
	[cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[cancelBtn addTarget:self action:@selector(handelButtonAction:) forControlEvents:UIControlEventTouchDown];
	[self addSubview:cancelBtn];
	
	UIImageView *imageLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(159, HEIGHT - 35, 0.5, 35)];
	imageLine2.backgroundColor = [UIColor grayColor];
	[self addSubview:imageLine2];
	
	_doneButton = [[UIButton alloc] initWithFrame:CGRectMake(160, HEIGHT - 35, 160, 35)];
	_doneButton.tag =1;
	[_doneButton setTitle:@"Submit" forState: UIControlStateNormal];
	[_doneButton setTitleColor:[UIColor colorWithRed:0/255.0 green:91/255.0 blue:249/255.0 alpha:1.0] forState:UIControlStateNormal];
	[_doneButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[_doneButton addTarget:self action:@selector(handelButtonAction:) forControlEvents:UIControlEventTouchDown];
	[self addSubview:_doneButton];
	_doneButton.enabled = NO;
	_doneButton.alpha = 0.5;
}

- (void)show {
	_strongSelf = self;
	
	UIApplication* application = [UIApplication sharedApplication];
	UIWindow* window = [application keyWindow];
	UIViewController* rootViewController = [window rootViewController];
	UIView* rootView = [rootViewController view];
	
	CGRect rootBounds = [rootView bounds];
	CGFloat rootWidth = CGRectGetWidth(rootBounds);
	CGFloat rootHeight = CGRectGetHeight(rootBounds);
	
	[rootView addSubview: _maskView];
	[_maskView mas_makeConstraints: ^(MASConstraintMaker* make) {
		make.edges.equalTo(rootView);
	}];
	
	_originalDialogFrame = CGRectMake((rootWidth - WIDTH) / 2, (rootHeight - HEIGHT) / 2, WIDTH, HEIGHT);
	[_dialogView setFrame: _originalDialogFrame];
	[rootView addSubview: _dialogView];
}

- (void)dismiss {
	[_maskView removeFromSuperview];
	[_dialogView removeFromSuperview];
	
	_strongSelf = nil;
}

-(void)handelButtonAction:(UIButton *)button {
    



}

-(BOOL)isValidateEmail:(NSString *)email {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	 [self changeViewFrame:0];
	[self checkTextLength];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
  
	[self checkTextLength];
	if(textView.tag == 1) {
		[self changeViewFrame:100];
	}
	else if(textView.tag == 2) {
		 [self changeViewFrame:140];
	}
	
	return YES;
}




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	[self checkTextLength];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	[self changeViewFrame:160];

	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	  [self changeViewFrame:0];
}

-(void)checkTextLength {
	if(_textView1.text.length >0 || _textView2.text.length> 0 || _textView3.text.length >0) {
		_doneButton.enabled = YES;
		_doneButton.alpha = 1.0;
	}
	else {
		_doneButton.enabled = NO;
		_doneButton.alpha = 0.5;
	}
}

-(void)changeViewFrame: (int)number {
	[UIView animateWithDuration:0.3 animations:^{
		_dialogView.frame = CGRectMake(_originalDialogFrame.origin.x, _originalDialogFrame.origin.y - number, _originalDialogFrame.size.width, _originalDialogFrame.size.height);
	}];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[_textView1 resignFirstResponder];
	[_textView2 resignFirstResponder];
	[_textView3 resignFirstResponder];
	[_emailTextField resignFirstResponder];
	[self changeViewFrame:0];
	
}

-(void)textViewResignFirstResponder {
	[_textView1 resignFirstResponder];
	[_textView2 resignFirstResponder];
	[_textView3 resignFirstResponder];
	[_emailTextField resignFirstResponder];
}


@end

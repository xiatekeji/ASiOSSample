#import "ASHomeViewController_SidebarContentView.h"

#import <Masonry/Masonry.h>
#import "ASContactUsDialog.h"
#import "ASHomeViewController.h"
#import "ASSidebarLayout.h"
#define HEADER_IMAGE_WIDTH (CGFloat)1024
#define HEADER_IMAGE_HEIGHT (CGFloat)500
#define HEADER_IMAGE_ASPECT_RATIO (CGFloat)(HEADER_IMAGE_HEIGHT / HEADER_IMAGE_WIDTH)

@interface ASHomeViewController()

- (void)openCart;
- (void)signIn;
- (void)confirmForSigningOut;

@end

#pragma mark -

@interface ASHomeViewController_SidebarContentView()<UIAlertViewDelegate> {
	ASHomeViewController* __weak _owner;
	IBOutlet UIImageView* _headerImageView;
	
	IBOutlet UIView* _passwordButtonPanel;
	
	IBOutlet UIView* _contentView;
	IBOutlet UILabel* _cartLabel;
	IBOutlet UILabel* _orderStatusLabel;
	IBOutlet UILabel* _contactUsLabel;
	IBOutlet UILabel* _versionLabel;
	IBOutlet UILabel* _signInOutLabel;
	IBOutlet UILabel* _usernameLabel;
	
	NSInteger _password;
	
	UIAlertView* _environmentAlertView;
	
	BOOL _userSignedIn;
}

@end

#pragma mark -

@implementation ASHomeViewController_SidebarContentView

+ (instancetype)allocWithOwner: (ASHomeViewController*)owner {
	NSParameterAssert(owner != nil);
	
	ASHomeViewController_SidebarContentView* instance = [super alloc];
	instance->_owner = owner;
	
	return instance;
}

- (instancetype)initWithFrame: (CGRect)frame {
	self = [super initWithFrame: frame];
	if(self != nil) {
		[self buildViewHierachy];
		[self applyGestureRecognizers];
		
		[self updateVersionLabel];
		
	}
	
	return self;
}

#pragma mark Layout

- (void)buildViewHierachy {
	UIView* tempView = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner: self options: 0][0];
	for(UIView* subview in [tempView subviews]) {
		[super addSubview: subview];
	}
	
	[_headerImageView mas_makeConstraints: ^(MASConstraintMaker* make) {
		make.left.top.right.equalTo(self);
		make.height.equalTo(_headerImageView.mas_width).multipliedBy(HEADER_IMAGE_ASPECT_RATIO);
	}];
	
	[_passwordButtonPanel mas_makeConstraints: ^(MASConstraintMaker* make) {
		make.edges.equalTo(_headerImageView);
	}];
	
	[_contentView mas_makeConstraints: ^(MASConstraintMaker* make) {
		make.left.right.bottom.equalTo(self);
		make.top.equalTo(_headerImageView.mas_bottom);
	}];
 
}

- (void)applyGestureRecognizers {
	[_cartLabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)]];
	[_orderStatusLabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)]];
	[_contactUsLabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)]];
	[_signInOutLabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)]];
}

#pragma mark Private



- (void)handleTap: (UITapGestureRecognizer*)tapper {
	UIView* target = [tapper view];
	
	if(target == _cartLabel) {
		[_owner openCart];
		
		return;
	}
	

	
	if(target == _signInOutLabel) {
		if(_userSignedIn) {
			[_owner confirmForSigningOut];
		}
		else {
			[_owner signIn];
		}
		
	}
}


- (void)updateVersionLabel {
	NSString* version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];;
	NSString* build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*)kCFBundleVersionKey];;
	[_versionLabel setText: [[NSString alloc] initWithFormat: @"Version: %@ build%@", version, build]];
}

#pragma mark UIAlertViewDelegate

- (void)alertView: (UIAlertView*)alertView didDismissWithButtonIndex: (NSInteger)buttonIndex {
	if(alertView == _environmentAlertView) {
		_environmentAlertView = nil;
		
		if(buttonIndex == [alertView cancelButtonIndex]) {
			return;
		}
		
		
		return;
	}
}

@end

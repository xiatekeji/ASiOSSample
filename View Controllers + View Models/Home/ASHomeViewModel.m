#import "ASHomeViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ASSignOutViewModel.h"
#import "ASUser.h"
#import "ASUserLocator.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"

float scale = (540.0/720.0); // 滚动图片比例

@interface ASHomeViewModel()

@property(nonatomic) BOOL shouldDisplayProgressHud;

@property(nonatomic) BOOL signedIn;

@property(nonatomic, nullable) NSString* account;

@property(nonatomic, nonnull) ASSignOutViewModel* signOutViewModel;

@property(nonatomic) BOOL inProgress;
@property(nonatomic, copy, nullable) NSString* progressMessage;

@end

#pragma mark -

@implementation ASHomeViewModel

- (instancetype)init{
	self = [super init];
	if (self) {
		_imageArray = [NSMutableArray arrayWithArray:@[@"bg_home_ad_photo_book.jpg",@"bg_home_ad_table_top.jpg",@"bg_home_ad_canvas.jpg",@"bg_home_ad_frame.jpg",@"bg_home_ad_trial.jpg"]];
		_titleArray = @[@"Make Layflat Book  >",@"Make Table Top Frame >",@"Make Canvas Print >",@"Make Modern Frame >",@"Get My Trial >"];
		_homeRect = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*scale);
		_productImages = [NSMutableArray arrayWithArray:@[@"icon_home_entry_trial",@"icon_home_entry_photo_book",@"icon_home_entry_canvas",@"icon_home_entry_frame",@"icon_home_entry_prints",@"icon_home_entry_upload"]];
		_productTitles = @[@"$5 Trial",@"Photo Books",@"Canvas",@"Frames",@"Prints",@"Upload Photos"];
		
		[self changeSignInStateInTheFuture];
		
		if(_signOutViewModel == nil) {
			_signOutViewModel = [[ASSignOutViewModel alloc] init];
		}
		
		[self bindWithSignOutViewModel];
	}
	return self;
}

- (void)changeSignInStateInTheFuture {
	ASUserLocator* userLocator = [ASUserLocator sharedInstance];
	[RACObserve(userLocator, user) subscribeNext: ^ (ASUser* user) {
		if(user == nil) {
			[self setSignedIn: FALSE];
			[self setAccount: nil];
		}
		else {
			[self setSignedIn: TRUE];
			
			NSString* account = [user account];
			[self setAccount: account];
		}
	}];
}

- (void)bindWithSignOutViewModel {
	RAC(self, inProgress) = RACObserve(self, signOutViewModel.inProgress);
	RAC(self, progressMessage) = RACObserve(self, signOutViewModel.progressMessage);
}

- (void)doSignOut {
	[_signOutViewModel doSignOut];
}

#pragma mark ScrollDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	self.pageIndex = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
}

//- (void)setIsTrial:(BOOL)isTrial{
//    _isTrial = isTrial;
//}
- (void)setImageArray:(NSMutableArray *)imageArray{
	_imageArray = imageArray;
}

@end

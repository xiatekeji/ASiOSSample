#import <UIKit/UIKit.h>
#import "ASSignInViewController.h"
@class ASSignInViewController;
@class ASHomeViewModel;

@interface ASHomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (instancetype)initWithCoder: (NSCoder*)coder __unavailable;
- (instancetype)initWithNibName: (NSString*)nibName bundle: (NSBundle*)nibBundle __unavailable;

@property(nonatomic, strong) ASHomeViewModel* viewModel;



@end

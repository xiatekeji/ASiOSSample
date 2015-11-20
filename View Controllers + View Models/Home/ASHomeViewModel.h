#import <ReactiveViewModel/ReactiveViewModel.h>
#import <UIKit/UIKit.h>

@interface ASHomeViewModel : RVMViewModel<UIScrollViewDelegate>

@property (strong ,nonatomic,readonly) NSMutableArray *imageArray; // 滚动图片数组

@property (strong ,nonatomic,readonly) NSArray *titleArray; // 滚动文字数组

@property (strong ,nonatomic,readonly) NSArray *productTitles;

@property (strong ,nonatomic,readonly) NSMutableArray *productImages;

@property (assign ,nonatomic,readonly) CGRect homeRect;

@property (assign ,nonatomic) NSInteger pageIndex;

@property (assign ,nonatomic) BOOL isTrial;

@property(nonatomic, readonly) BOOL signedIn;

@property(nonatomic, readonly, nullable) NSString* account;

@property(nonatomic, readonly) BOOL inProgress;
@property(nonatomic, copy, readonly, nullable) NSString* progressMessage;

- (void)doSignOut;

@end

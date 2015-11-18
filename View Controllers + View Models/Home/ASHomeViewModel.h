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

/**
 * @brief 是否需要显示进度指示器。
 */
@property(nonatomic, readonly) BOOL shouldDisplayProgressHud;


@end

#import "ASHomeViewModel.h"

#import "ASSignInViewController.h"

float scale = (540.0/720.0); // 滚动图片比例

@interface ASHomeViewModel()

@property(nonatomic) BOOL shouldDisplayProgressHud;

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
       
       
    }
    return self;
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

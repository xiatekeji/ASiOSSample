#import "ASHomeViewController.h"

#import <Masonry/Masonry.h>

#import "ASCustomNaviBar.h"
#import "ASHomeAdverScrollView.h"
#import "ASHomeViewController_SidebarContentView.h"
#import "ASHomeViewModel.h"
#import "ASProductCell.h"
#import "ASSidebarLayout.h"
#import "ASSignInViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ASNavigator.h"
#import "ModalCenterReform.h"
#define PREFERRED_SIDEBAR_WIDTH (CGFloat)260
#define SidebarContentView ASHomeViewController_SidebarContentView

@interface ASHomeViewController()<UIAlertViewDelegate> {
	UIView* _rootView;
	ASSidebarLayout* _sidebarLayout;
	
	UIView *_sidebarView;
	// 广告滑动页
	ASHomeAdverScrollView *_adverScrollView;
	// 自定义导航bar
	ASCustomNaviBar *_customNaviBar;
	//产品列表
	UITableView *_homeTableView;
	

	
	UIAlertView* _signOutAlertView;
	
}

@end


@implementation ASHomeViewController





#pragma mark  Activity
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    self.viewModel = [[ASHomeViewModel alloc]init];

    [self buildViewHierachy];
    UIView *rootSubview = _sidebarLayout.mainView;
    [self initAdeverScrollView:rootSubview];
    [self initHomeCustonNaviBar:rootSubview];
    [self initHomeTableViewIntoView:rootSubview];
}

- (void)viewWillAppear: (BOOL)animated {
    [super viewWillAppear: animated];
    [UIApplication sharedApplication].statusBarStyle =   UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
    [_viewModel setActive: TRUE];

    
}

- (void)viewDidDisappear: (BOOL)animated {
    [super viewWillDisappear: animated];

    [_viewModel setActive: FALSE];
    
}
- (void)viewWillDisappear: (BOOL)animated {
    [super viewWillDisappear: animated];
    
    [[super navigationController] setNavigationBarHidden: FALSE animated: TRUE];
}
#pragma mark Layout
- (void)buildViewHierachy {
    UIView* rootView = [super view];
    _rootView = rootView;
    
    ASSidebarLayout* sidebarLayout = [[ASSidebarLayout alloc] init];
    // FIXME 应禁止接受打开侧栏的手势
    [sidebarLayout setAcceptsSideOpeningGesture: TRUE];
    [sidebarLayout setAcceptsSideClosingGesture:TRUE];
    [sidebarLayout setSidebarLength: PREFERRED_SIDEBAR_WIDTH];
    [rootView addSubview: sidebarLayout];
    [sidebarLayout mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.edges.equalTo(rootView);
    }];
    [sidebarLayout layoutIfNeeded];
    _sidebarLayout = sidebarLayout;
    
    
    UIView* sidebarView = [sidebarLayout sidebarView];
    
    
    UIView* sidebarContentView = [[SidebarContentView allocWithOwner: self] init];
    [sidebarView addSubview: sidebarContentView];
    [sidebarContentView mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.edges.equalTo(sidebarView);
    }];
    [sidebarContentView layoutIfNeeded];
    
    UIView* maskView = [sidebarLayout maskView];
    // XXX 可能需要调整遮罩层背景色。
    [maskView setBackgroundColor: [UIColor colorWithWhite: 0 alpha: 0.75]];
    
    // TODO
}
- (void)initAdeverScrollView:(UIView *)view{
    _adverScrollView  = [[ASHomeAdverScrollView alloc]initWithViewModel:self.viewModel];
    [_adverScrollView.singleTap addTarget:self action:@selector(intoNextStep)];
    [view addSubview:_adverScrollView];
    
}


- (void)initHomeCustonNaviBar:(UIView *)view{
    _customNaviBar = [[ASCustomNaviBar alloc]init];
    @weakify(self)
    _customNaviBar.leftBarItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self leftSideIn];
        return [RACSignal empty];
    }];

    _customNaviBar.rightBarItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self openCart];
        return [RACSignal empty];
    }];
    [view addSubview:_customNaviBar];
    [_customNaviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
        make.height.equalTo(@60);
    }];
}
- (void)userDidBack{
    NSLog(@"back");
}
- (void)initHomeTableViewIntoView:(UIView *)view{
    _homeTableView = [[UITableView alloc]init];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.rowHeight = 70;
    _homeTableView.showsVerticalScrollIndicator = NO;
    [RACObserve(self.viewModel, isTrial) subscribeNext:^(id x) {
        [_homeTableView reloadData];
    }];
    [view addSubview:_homeTableView];
    [_homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_adverScrollView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
		make.left.and.right.equalTo(self.view).offset(0);
//        make.width.equalTo(self.view);
    }];
    
}
#pragma mark Private


- (void)leftSideIn{
    
    [_sidebarLayout setSideVisible:YES animated:YES];
    
}



- (void)signIn {
    [_sidebarLayout setSideVisible: FALSE animated: TRUE];
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"signIn" andParameters:nil];
    [[ASNavigator shareModalCenter] presentViewController:reform.controller parameters:reform.modalParamter isAnimation:YES completion:^{
        
    }];
}



// 进入选择产品
- (void)intoNextStep{
    [self swithProductWithIndex:self.viewModel.pageIndex isAdverScrollView:YES];
}
// 根据序号选择相应模块
- (void)swithProductWithIndex:(NSUInteger)index isAdverScrollView:(BOOL)scrollView{
    if (scrollView) {
		switch (index) {
			case 0:
			{
				[self goToPhotoBook];
				
				break;
			}
			
			case 2:
			{
				[self goToCanvas];
				
				break;
			}
			
			case 3:
			{
				[self goToFrame];
				
				break;
			}
			
			case 1:
			{
				[self goToTableTop];
				
				break;
			}
			
			case 4:
			{
				[self goToTrial];
				
				break;
			}
			
			default:
			{
				assert(FALSE);
				
				break;
			}
		}
    }else{
		switch(index) {
			case 0:
			{
               
				[self goToTrial];
				
				break;
			}
			
			case 1:
			{
				[self goToPhotoBook];
				
				break;
			}
			
			case 2:
			{
				[self goToCanvas];
				
				break;
			}
			case 3:
			{
				[self goToFrame];
				
				break;
			}
			case 4:
			{
				[self goToPrints];
				
				break;
			}
			
			case 5:
			{
                [self goToUploadPhotos];
				
				break;
			}
			default:
			{
				assert(FALSE);
				
				break;
			}
		}
	}
}

- (void)goToTrial {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"bookProduct" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}

- (void)goToPhotoBook {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"bookProduct" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}

- (void)goToFrame {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"frameProduct" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}

- (void)goToCanvas {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"canvasProduct" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}

- (void)goToPrints {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"album" andParameters:nil];
    [[ASNavigator shareModalCenter] presentViewController:reform.controller parameters:reform.modalParamter isAnimation:YES completion:nil];
}
- (void)goToUploadPhotos{
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"uploadPhotos" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}
- (void)goToTableTop{
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"tableTopProduct" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}
- (void)openCart {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"openCart" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
    [_sidebarLayout setSideVisible: FALSE animated: TRUE];
    
}
#pragma mark Override
//
//- (NSUInteger)supportedInterfaceOrientations {
//	return UIInterfaceOrientationMaskPortrait;
//}
#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.productImages.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0 && !self.viewModel.isTrial) {
        return 0;
    }

    return tableView.rowHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ASProductCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASProductCell productCell]];
    if (cell == nil) {
        cell = [[ASProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ASProductCell productCell]];
        
    }

    
    if (indexPath.row == 0 && !self.viewModel.isTrial) {
        cell.hidden = YES;
        
    }else{
        [cell loadDataWithImage:self.viewModel.productImages[indexPath.row] andName:self.viewModel.productTitles[indexPath.row]];
    }
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self swithProductWithIndex:indexPath.row isAdverScrollView:NO];
}
#pragma mark Center

#pragma mark UIAlertView

- (void)alertView: (UIAlertView*)alertView didDismissWithButtonIndex: (NSInteger)buttonIndex {
	if(alertView == _signOutAlertView) {
		if(buttonIndex != [alertView cancelButtonIndex]) {
			switch(buttonIndex - [alertView firstOtherButtonIndex]) {
				case 0: // Continue
				{
					
					break;
				}
			}
		}
		
		return;
	}
}

#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
}
@end
//
//  ASNavigationController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/13.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "ASNavigator.h"
#import "ASNavigationController.h"

@interface ASNavigationController ()

@end

@implementation ASNavigationController
- (void)skipPageProtocol:(NSDictionary *)parameters{
    if (parameters ) {
        UIViewController <ASNavigatable>*VC = self.topViewController;
        if ([VC respondsToSelector:@selector(skipPageProtocol:)]) {
            [VC skipPageProtocol:parameters];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 重载导航栏的返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    }
} // 压栈时候创建自定义导航栏按钮
-(UIBarButtonItem*)customLeftBackButton{
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    btn.frame=CGRectMake(0, 23, 40, 40);
    
    
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
    
    return backItem;
} // 自定义导航栏按钮

-(void)popself
{
    [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
    
} // 出栈动画
@end

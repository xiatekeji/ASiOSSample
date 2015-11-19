//
//  ASAlbumViewController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASAlbumViewController.h"
#import "DemoButton.h"
#import "ASNavigator.h"
#import "ModalCenterReform.h"
@interface ASAlbumViewController ()

@end

@implementation ASAlbumViewController
- (void)skipPageProtocol:(NSDictionary *)parameters{
    if ([parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    self.navigationItem.rightBarButtonItem =[self customRightBackButton];

}
-(UIBarButtonItem*)customLeftBackButton{
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    btn.frame=CGRectMake(0, 23, 40, 40);
    
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    return backItem;
} // 自定义导航栏按钮
-(UIBarButtonItem*)customRightBackButton{
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    btn.frame=CGRectMake(0, 23, 40, 40);
    
    
    [btn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
    return backItem;
} // 自定义导航栏按钮
- (void)back{
    [[ASNavigator shareModalCenter]dismissCurrentModalViewControlleAnimation:YES completion:nil];
}
- (void)next{
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"frameEdit" andParameters:nil];
    [[ASNavigator shareModalCenter]dismissCurrentModalViewControlleAnimation:YES completion:^{
        [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
    }];
}



@end

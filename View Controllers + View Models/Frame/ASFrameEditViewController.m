//
//  ASFrameEditViewController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASFrameEditViewController.h"
#import "DemoButton.h"
#import "ASNavigator.h"
#import "ModalCenterReform.h"
@interface ASFrameEditViewController ()

@end

@implementation ASFrameEditViewController

- (void)skipPageProtocol:(NSDictionary *)parameters{
    if ([parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    DemoButton *demo = [[DemoButton alloc]initButtonWithDemo:@"Restart" action:^{
        [[ASNavigator shareModalCenter] popHomeViewControllerWithAnimation:YES];
    }];
    
    DemoButton *demo1 = [[DemoButton alloc]initButtonWithDemo:@"Cart" action:^{
        ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"openCart" andParameters:nil];
        [[ASNavigator shareModalCenter] pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
    }];
    CGRect rect = demo1.frame;
    rect.origin.x += 250;
    demo1.frame = rect;
    [self.view addSubview:demo1];
    [self.view addSubview:demo];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

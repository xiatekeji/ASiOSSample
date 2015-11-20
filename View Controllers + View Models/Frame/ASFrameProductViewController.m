//
//  ASFrameProductViewController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASFrameProductViewController.h"
#import "DemoButton.h"
#import "ASNavigator.h"
#import "ModalCenterReform.h"
@interface ASFrameProductViewController ()

@end

@implementation ASFrameProductViewController

- (void)skipPageProtocol:(NSDictionary *)parameters{
    if ([parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    DemoButton *demo = [[DemoButton alloc]initButtonWithDemo:@"Frame Size" action:^{
        ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"frameSize" andParameters:nil];
        [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
    }];
    [self.view addSubview:demo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

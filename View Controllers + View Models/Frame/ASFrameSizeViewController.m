//
//  ASFrameSizeViewController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASFrameSizeViewController.h"
#import "DemoButton.h"
#import "ASNavigator.h"
#import "ModalCenterReform.h"
@interface ASFrameSizeViewController ()

@end

@implementation ASFrameSizeViewController

- (void)skipPageProtocol:(NSDictionary *)parameters{
    if ([parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    DemoButton *demo = [[DemoButton alloc]initButtonWithDemo:@"Into Album" action:^{
        ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"album" andParameters:nil];
        [[ASNavigator shareModalCenter] presentViewController:reform.controller parameters:reform.modalParamter isAnimation:YES completion:nil];
    }];
    [self.view addSubview:demo];
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

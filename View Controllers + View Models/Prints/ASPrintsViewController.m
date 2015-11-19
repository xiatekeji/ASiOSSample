//
//  ASPrintsViewController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/19.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASPrintsViewController.h"
#import "DemoButton.h"
#import "ASNavigator.h"
#import "ModalCenterReform.h"
@interface ASPrintsViewController ()

@end

@implementation ASPrintsViewController

- (void)skipPageProtocol:(NSDictionary *)parameters{
    if ([parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    DemoButton *demo = [[DemoButton alloc]initButtonWithDemo:@"album" action:^{
        ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"bookSize" andParameters:nil];
        [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
    }];
    [self.view addSubview:demo];
}
@end

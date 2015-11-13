//
//  ViewController.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "UISizeViewController.h"

#import "ASModalCenterControll.h"
#import "EventBusDemoViewController.h"
#import "ModalCenterReform.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int a = 0;
    while (a < 6) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
		btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
        switch (a) {
            case 1:
                [btn setTitle:@"Book" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(books:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [btn setTitle:@"BookSize" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(booksize:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                [btn setTitle:@"BookEdit" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(bookedit:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 4:
                [btn setTitle:@"FrameEdit" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(frameEdit:) forControlEvents:UIControlEventTouchUpInside];
                break;
				
			case 5:
			{
				[btn setTitle: @"Events" forState: UIControlStateNormal];
				[btn addTarget: self action: @selector(demonstrateEvents) forControlEvents: UIControlEventTouchUpInside];
				
				break;
			}
			
            default:
                break;
        }
        [self.view addSubview:btn];
        a++;
    }
}
- (void)books:(UIButton *)sender {
   
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"book" andParameters:nil];
    [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];

}
- (void)booksize:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"size" andParameters:nil];
    [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}
- (void)bookedit:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"bookEdit" andParameters:nil];
    [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];

}
- (void)frameEdit:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"frameEdit" andParameters:nil];
       [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}

- (void)demonstrateEvents {
	UIViewController* viewController = [[EventBusDemoViewController alloc] init];
	[[ASModalCenterControll shareModalCenter] pushViewController: viewController parameters: nil isAnimation: TRUE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

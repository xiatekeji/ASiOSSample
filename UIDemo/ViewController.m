//
//  ViewController.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "UISizeViewController.h"
#import "ViewController.h"
#import "ASModalCenterControll.h"
#import "ModalCenterReform.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentiier:@"book" andParameters:@{@"book":@"1"}];
    NSLog(@"reform ica = %p",reform);
    NSMutableArray <ModalCenterReform *>*array = [[NSMutableArray alloc]initWithArray:@[reform]];
    for (ModalCenterReform *reform in array) {
        reform.modalParameters = @{@"OK":@"true"};
    }
    NSLog(@"array = %@ p = %@",array[0],reform.modalParameters);
    UISizeViewController *vc = [[UISizeViewController alloc]init];
    [self addChildViewController:vc];
    int a = 0;
    while (a < 5) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        switch (a) {
            case 1:
                btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
                [btn setTitle:@"Book" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(books:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                   btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
                [btn setTitle:@"BookSize" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(booksize:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                   btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
                [btn setTitle:@"BookEdit" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(bookedit:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 4:
                   btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
                [btn setTitle:@"FrameEdit" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(frameEdit:) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                break;
        }
        [self.view addSubview:btn];
        a++;
    }
}
- (void)books:(UIButton *)sender {
   
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentiier:@"book" andParameters:@{@"Modal":@"book"}];
    [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParameters isAnimation:YES];

}
- (void)booksize:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentiier:@"size" andParameters:@{@"Modal":@"size"}];
    [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParameters isAnimation:YES];
}
- (void)bookedit:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentiier:@"bookEdit" andParameters:@{@"Modal":@"bookEdit"}];
    [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParameters isAnimation:YES];

}
- (void)frameEdit:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentiier:@"frameEdit" andParameters:@{@"Modal":@"FrameEdit"}];
    [[ASModalCenterControll shareModalCenter] pushViewController:reform.controller parameters:reform.modalParameters isAnimation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

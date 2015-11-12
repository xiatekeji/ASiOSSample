//
//  UISizeViewController.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "ASNavigator.h"
#import "ModalCenterReform.h"
#import "UISizeViewController.h"

@interface UISizeViewController ()<ASNavigatable>

@end

@implementation UISizeViewController{
    NSDictionary *_p;
}
- (void)skipPageProtocola:(NSDictionary *)parameters{
    if ( [parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
        NSLog(@"p = %@",[parameters objectForKey:@"title"]);
    }
    
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

      
   
        
        int a = 0;
        while (a < 6) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            switch (a) {
                case 1:
                    btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
                    [btn setTitle:@"Book" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(books:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 2:
                    btn.frame = CGRectMake(self.view.frame.size.width/2-75, a*100, 150, 50);
                    [btn setTitle:@"Push Web" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(booksize:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 3:
                    btn.frame = CGRectMake(self.view.frame.size.width/2-60, a*100, 120, 50);
                    [btn setTitle:@"Present Size" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(bookedit:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 4:
                    btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
                    [btn setTitle:@"POP HOME" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(frameEdit:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 5:
                    btn.frame = CGRectMake(self.view.frame.size.width/2-50, a*100, 100, 50);
                    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                    
                default:
                    break;
            }
            [self.view addSubview:btn];
            a++;
        }

}
- (void)books:(UIButton *)sender {

    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"bookEdit" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];

}
- (void)booksize:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"hao123" andParameters:nil];
    [[ASNavigator shareModalCenter]pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
}
- (void)bookedit:(UIButton *)sender {
    ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"size" andParameters:nil];
    [[ASNavigator shareModalCenter]presentViewController:reform.controller parameters:reform.modalParamter isAnimation:YES completion:^{
        
    }];
}
- (void)frameEdit:(UIButton *)sender {
    [[ASNavigator shareModalCenter] popHomeViewControllerWithAnimation:YES];
}
- (void)dismiss:(UIButton *)sender {
    [[ASNavigator shareModalCenter] dismissCurrentModalViewControlleAnimation:YES completion:nil];
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
